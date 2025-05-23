#include "dgemm.h"

/*
   matrix multiply using asm, *unaligned*
   DIM is defined in dgemm.h
*/
void mmasmu2(double* a, double* b, double* c)
{
   for (int i=0; i<DIM; ++i) 
      for (int j=0; j<DIM; j+=4) {
         __m256d c0 = _mm256_set1_pd(0.0);
         for (int k=0; k<DIM; ++k) {
            __m256d tmp = _mm256_loadu_pd(b+k*DIM+j);
            tmp = _mm256_mul_pd(_mm256_broadcast_sd(a+i*DIM+k), tmp);
            c0 = _mm256_add_pd(c0, tmp);
         }
         _mm256_storeu_pd(c+i*DIM+j, c0);
      }
}
