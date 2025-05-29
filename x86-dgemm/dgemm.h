#include <x86intrin.h>
// #include <immintrin.h>
#include <omp.h>

#define   DIM       (1024) // (4096) // (2048) // (512)
#define   TOL       (1e-10)
#define   UNROLL    (4)
#define   BLOCKSIZE (32)
#define   ALIGN     (64) // align on 64-byte boundary

void mm2d(double *c[], double *a[], double *b[]);
void mm(int n, double* a, double* b, double* c);
void mmasmu(int n, double* a, double* b, double* c);
void mmasmu2(double* a, double* b, double* c);
void mmasm(int n, double* a, double* b, double* c);
void mmasmlu(int n, double* a, double* b, double* c);
void block(int n, int si, int sj, int sk, double* a, double* b, double* c);
void mmcb(int n, double* a, double* b, double* c);
void mmomp(int n, double* a, double* b, double* c);
