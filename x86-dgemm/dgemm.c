#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

#include "dgemm.h"

int main()
{
   int i,j,k;

   double *a[DIM], *b[DIM], *c[DIM],
          *a1, *b1, *c1, *c2, *c3, *c4, *c5, *c6,
          ref;

   for (int i=0; i<DIM; ++i) {
      a[i] = (double*)malloc(DIM * sizeof(double));
      b[i] = (double*)malloc(DIM * sizeof(double));
      c[i] = (double*)malloc(DIM * sizeof(double));
   }

/*
   a1 = (double*)malloc(DIM*DIM*sizeof(double));
   b1 = (double*)malloc(DIM*DIM*sizeof(double));
   c1 = (double*)malloc(DIM*DIM*sizeof(double));
   c2 = (double*)malloc(DIM*DIM*sizeof(double));
   c3 = (double*)malloc(DIM*DIM*sizeof(double));
   c4 = (double*)malloc(DIM*DIM*sizeof(double));
   c5 = (double*)malloc(DIM*DIM*sizeof(double));
   c6 = (double*)malloc(DIM*DIM*sizeof(double));
*/

   a1 = (double*)aligned_alloc(ALIGN, DIM*DIM*sizeof(double));
   b1 = (double*)aligned_alloc(ALIGN, DIM*DIM*sizeof(double));
   c1 = (double*)aligned_alloc(ALIGN, DIM*DIM*sizeof(double));
   c2 = (double*)aligned_alloc(ALIGN, DIM*DIM*sizeof(double));
   c3 = (double*)aligned_alloc(ALIGN, DIM*DIM*sizeof(double));
   c4 = (double*)aligned_alloc(ALIGN, DIM*DIM*sizeof(double));
   c5 = (double*)aligned_alloc(ALIGN, DIM*DIM*sizeof(double));
   c6 = (double*)aligned_alloc(ALIGN, DIM*DIM*sizeof(double));

   srand(time(NULL));

   for (i=0; i<DIM; ++i)
   for (j=0; j<DIM; ++j) {
      a[i][j] = a1[i*DIM+j] = rand();
      b[i][j] = b1[i*DIM+j] = rand();
//      a[i][j] = a1[i*DIM+j] = 1.0;  // for debug
//      b[i][j] = b1[i*DIM+j] = 1.0;  // for debug
      c5[i*DIM+j] = 0.0; // needed only for cache blocking alg
      c6[i*DIM+j] = 0.0; // needed only for cache blocking alg
   }

   clock_t t1, t2;
   long double wtime, wtime1, flops, gf;
   /* Total number of fl ops in matmul is 2*N^3.
      See e.g. Dongarra el al (1984)
      IMPLEMENTING LINEAR ALGEBRA ALGORITHMS FOR DENSE MATRICES
      ON A VECTOR PIPELINE MACHINE,
      SIAM REVIEW Vol. 26, No. 1, January, 1984
      https://scispace.com/pdf/implementing-linear-algebra-algorithms-for-dense-matrices-on-51cy0mi8tk.pdf
   */
   flops = 2.0 * (long double)DIM * (long double)DIM * (long double)DIM;

   t1 = clock();   
   mm2d(c,a,b);  
   t2 = clock();
   wtime = (long double)(t2 - t1) / CLOCKS_PER_SEC;
   gf = flops / wtime * 1e-9;
   printf("%10s %10.2Le %s %10.2Le %s\n", "mm2d:", wtime, "s", gf, "GF");

   t1 = clock();   
   mm(DIM, a1, b1, c1);
   t2 = clock();
   wtime1 = (long double)(t2 - t1) / CLOCKS_PER_SEC;
   gf = flops / wtime1 * 1e-9;
   printf("%10s %10.2Le %s %10.2Le %s\n", "mm:", wtime1, "s", gf, "GF");

   t1 = clock();   
   mmasmu(DIM, a1, b1, c2);
   t2 = clock();
   wtime = (long double)(t2 - t1) / CLOCKS_PER_SEC;
   gf = flops / wtime * 1e-9;
   printf("%10s %10.2Le %s %10.2Le %s, %10.2Le faster than mm version\n",
          "mmasmu:", wtime, "s", gf, "GF", wtime1/wtime);

   t1 = clock();   
   mmasm(DIM, a1, b1, c3);
   t2 = clock();
   wtime = (long double)(t2 - t1) / CLOCKS_PER_SEC;
   gf = flops / wtime * 1e-9;
   printf("%10s %10.2Le %s %10.2Le %s, %10.2Le faster than mm version\n",
          "mmasm:", wtime, "s", gf, "GF", wtime1/wtime);

   t1 = clock();   
   mmasmlu(DIM, a1, b1, c4);
   t2 = clock();
   wtime = (long double)(t2 - t1) / CLOCKS_PER_SEC;
   gf = flops / wtime * 1e-9;
   printf("%10s %10.2Le %s %10.2Le %s, %10.2Le faster than mm version\n",
          "mmasmlu:", wtime, "s", gf, "GF", wtime1/wtime);

   t1 = clock();   
   mmcb(DIM, a1, b1, c5);
   t2 = clock();
   wtime = (long double)(t2 - t1) / CLOCKS_PER_SEC;
   gf = flops / wtime * 1e-9;
   printf("%10s %10.2Le %s %10.2Le %s, %10.2Le faster than mm version\n",
          "mmcb:", wtime, "s", gf, "GF", wtime1/wtime);

   double tomp1 = omp_get_wtime();
   mmomp(DIM, a1, b1, c6);
   double tomp2 = omp_get_wtime();
   wtime = (long double)(tomp2 - tomp1);
   gf = flops / wtime * 1e-9;
   printf("%10s %10.2Le %s %10.2Le %s, %10.2Le faster than mm version\n",
          "mmomp:", wtime, "s", gf, "GF", wtime1/wtime);

   // check
   #pragma omp parallel for collapse(2)
   for (i=0; i<DIM; ++i)
      for (j=0; j<DIM; ++j) {
         ref = 0.0;
         for (k=0; k<DIM; ++k)
            ref += a1[i*DIM + k] * b1[k*DIM + j];
         assert( fabs(c[i][j] - ref) < TOL );
         assert( fabs(c1[i*DIM + j] - ref) < TOL );
         assert( fabs(c2[i*DIM + j] - ref) < TOL );
         assert( fabs(c3[i*DIM + j] - ref) < TOL );
         assert( fabs(c4[i*DIM + j] - ref) < TOL );
         assert( fabs(c5[i*DIM + j] - ref) < TOL );
         assert( fabs(c6[i*DIM + j] - ref) < TOL );
/*
         if ( fabs(c4[i*DIM + j] - c1ref[i*DIM + j]) > TOL ) {
            printf("c4[ %d ]: %f  cref: %f\n", i*DIM + j, c4[i*DIM + j], c1ref[i*DIM + j]);
            printf("****** ERROR\n");
            exit(1);
         }
*/


      }
}
