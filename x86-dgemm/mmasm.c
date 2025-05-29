#include "dgemm.h"

/*
matrix multiply using asm, *aligned*

Note that j is changing by 4, *not* i.
See mm.c for a diagram
*/

void mmasm(int n, double* a, double* b, double* c)
{
   for (int i=0; i<n; ++i) 
      for (int j=0; j<n; j+=4) {
         __m256d c0 = _mm256_set1_pd(0.0);
         for (int k=0; k<n; ++k) {
            c0 = _mm256_add_pd(c0,
                    _mm256_mul_pd(_mm256_broadcast_sd(a+i*n+k),
                                  _mm256_load_pd(b+k*n+j) ));
         }
         _mm256_store_pd(c+i*n+j, c0);     
      }
}
