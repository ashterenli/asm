#include "dgemm.h"

/*
matrix multiply using asm, *aligned*, with loop unrolling

See mm.c for a diagram explaining i and j

The factor of 4 because there are 4 doubles in 256-bit vector
*/

void mmasmlu(int n, double* a, double* b, double* c)
{
   for (int i=0; i<n; ++i) 
      for (int j=0; j<n; j+=UNROLL*4) {
         __m256d sum[UNROLL];
         for (int u=0; u<UNROLL; ++u)
            sum[u] = _mm256_set1_pd(0.0);
         for (int k=0; k<n; ++k) {
            __m256d acast = _mm256_broadcast_sd(a+i*n+k);
            for (int u=0; u<UNROLL; ++u)
               sum[u] = _mm256_add_pd(sum[u],
                  _mm256_mul_pd(acast, _mm256_load_pd(b+k*n+j+u*4)));
         }
         for (int u=0; u<UNROLL; ++u)
            _mm256_store_pd(c+i*n+j+u*4, sum[u]);
      }
}
