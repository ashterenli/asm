#include "dgemm.h"

/*
matrix multiply using asm fma, *aligned*

Note that j is changing by 4, *not* i.
See mm.c for a diagram

Using _mm256_fmadd_pd:

https://www.intel.com/content/www/us/en/docs/cpp-compiler/developer-guide-reference/2021-10/mm-fmadd-pd-mm256-fmadd-pd.html

From:
https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html

Latency and Throughput
Arch               Latency Throughput (CPI)
Alderlake          4       0.5
Icelake Intel Core 4       0.5
Icelake Xeon       4       0.5
Sapphire Rapids    4       0.5
Skylake            4       0.5
*/

void mmfma(int n, double* a, double* b, double* c)
{
   for (int i=0; i<n; ++i) 
      for (int j=0; j<n; j+=4) {
         __m256d c0 = _mm256_set1_pd(0.0);
         for (int k=0; k<n; ++k)
            c0 = _mm256_fmadd_pd( _mm256_broadcast_sd(a+i*n+k),
                                  _mm256_load_pd(b+k*n+j), c0 );
         _mm256_store_pd(c+i*n+j, c0);     
      }
}
