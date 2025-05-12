#include "dgemm.h"

/* a single block of mm using asm, *aligned*, with loop unrolling */
void block(int n, int si, int sj, int sk, double* a, double* b, double* c)
{
   for (int i=si; i<si+BLOCKSIZE; ++i) 
      for (int j=sj; j<sj+BLOCKSIZE; j+=UNROLL*4) {
         __m256d sum[UNROLL];
         for (int u=0; u<UNROLL; ++u)
            sum[u] = _mm256_load_pd(c+i*n+j+u*UNROLL); // updating prior value
         for (int k=sk; k<sk+BLOCKSIZE; ++k) {
            __m256d acast = _mm256_broadcast_sd(a+i*n+k);
            for (int u=0; u<UNROLL; ++u)
               sum[u] = _mm256_add_pd(sum[u],
                  _mm256_mul_pd(acast, _mm256_load_pd(b+k*n+j+u*UNROLL)));
         }
         for (int u=0; u<UNROLL; ++u)
            _mm256_store_pd(c+i*n+j+u*UNROLL, sum[u]);     
      }
}
