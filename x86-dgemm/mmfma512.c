#include "dgemm.h"

/*
matrix multiply using asm fma, *aligned*

Note that j is changing by 8, *not* i.
See mm.c for a diagram

_mm512_fmadd_pd

https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html#text=_mm512_fmadd_pd
*/

void mmfma512(int n, double* a, double* b, double* c)
{
   for (int i=0; i<n; ++i) 
      for (int j=0; j<n; j+=8) {
         __m512d c0 = _mm512_set1_pd(0.0);
         for (int k=0; k<n; ++k)
            c0 = _mm512_fmadd_pd(
                    _mm512_broadcastsd_pd( _mm_load_sd(a+i*n+k) ),
                    _mm512_load_pd(b+k*n+j),
                    c0 );
         _mm512_store_pd(c+i*n+j, c0);     
      }
}
