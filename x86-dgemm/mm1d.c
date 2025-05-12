#include "dgemm.h"

/* naive matrix multiply, 1d arrays */
void mm1d(int n, double* a, double* b, double* c)
{
   for (int i=0; i<n; ++i) 
      for (int j=0; j<n; ++j)  {
         double cij = 0.0; // c[i*n+j];
         for (int k=0; k<n; ++k)
            cij += a[i*n+k] * b[k*n+j];
         c[i*n+j] = cij;
      }
}
