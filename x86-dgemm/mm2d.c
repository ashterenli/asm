#include "dgemm.h"

/* native matrix multiply, 2d arrays */
void mm2d(double *c[], double *a[], double *b[])
{
   int i, j, k;

   for (i=0; i<DIM; ++i) 
   for (j=0; j<DIM; ++j) {
      c[i][j] = 0.0;
      for (k=0; k<DIM; ++k) 
         c[i][j] += a[i][k] * b[k][j];
   }
}
