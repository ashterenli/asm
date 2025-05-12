#include "dgemm.h"

/* matrix multiply using asm, *unaligned* */
void mmasmu(int n, double* a, double* b, double* c)
{
   for (int i=0; i<n; ++i) 
      for (int j=0; j<n; j+=4) {
         __m256d c0 = _mm256_set1_pd(0.0);
         for (int k=0; k<n; ++k) {
            __m256d tmp = _mm256_loadu_pd(b+k*n+j);
            tmp = _mm256_mul_pd(_mm256_broadcast_sd(a+i*n+k), tmp);
            c0 = _mm256_add_pd(c0, tmp);
         }
         _mm256_storeu_pd(c+i*n+j, c0);     
      }
}
