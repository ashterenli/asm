#include "dgemm.h"

/*
naive matrix multiply, 1d arrays

Logically I think of 1d arrays folded into 2d matrices like this:

    -> j
   +------+
 | |      |
 V |      |
 i +------+

By analogy with row major layout,
j is fastest changing, i.e. 1d array
elements in order are a[j], a[j+1], a[j+2], etc.

i is changing by row, i.e. a[j+i*n] and a[j+(i+1)*n] are
separated by 1 row.
 */

void mm(int n, double* a, double* b, double* c)
{
   for (int i=0; i<n; ++i) 
      for (int j=0; j<n; ++j)  {
         double cij = 0.0; // c[i*n+j];
         for (int k=0; k<n; ++k)
            cij += a[i*n+k] * b[k*n+j];
         c[i*n+j] = cij;
      }
}
