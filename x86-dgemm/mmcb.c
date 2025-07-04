#include "dgemm.h"

/* matrix multiply using asm, *aligned*, with loop unrolling
   and cache blocking */
void mmcb(int n, double* a, double* b, double* c)
{
   for (int i=0; i<n; i+=BLOCKSIZE) 
   for (int j=0; j<n; j+=BLOCKSIZE) 
   for (int k=0; k<n; k+=BLOCKSIZE) 
      block(n, i, j, k, a, b, c);
}
