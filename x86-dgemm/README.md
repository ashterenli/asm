This example is motivated by sections "Going faster"
from Patterson and Hennessy "Computer Organization and Design".
I'm looking at 5th edition, from 2014.
However, my code differs from that in the book.

The parameters are set in `dgemm.h`:

```
#define   DIM       (1024) // (4096)
#define   TOL       (1e-10)
#define   UNROLL    (4)
#define   BLOCKSIZE (32)
```

The matrices to multiply are of sizes
`DIM` x `DIM`.
The results are considered correct if each
element of the product matrix is
whithin `TOL` from the reference value.
`UNROLL` is the level of loop unrolling,
and `BLOCKSIZE` is the block size for
the cache blocking version.

To build and run use the usual
```
make all
make run
```

8 omp threads are used by default (total threads on my laptop).
Adjust `OMP_NUM_THREDS` in `Makefile` for your system.

I compile with `-O3 -mavx2` (see the `Makefile`)
using `FreeBSD clang version 18.1.6`.

Running on FreeBSD 14.2 laptop with:

```
Architecture:            amd64
Byte Order:              Little Endian
Total CPU(s):            8
Thread(s) per core:      2
Core(s) per socket:      4
Socket(s):               1
Vendor:                  GenuineIntel
CPU family:              6
Model:                   142
Model name:              Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz
```

This CPU uses Kaby Lake R core:
https://en.wikichip.org/wiki/intel/cores/kaby_lake_r,
which is based on Kaby Lake microarch:
https://en.wikichip.org/wiki/intel/microarchitectures/kaby_lake,
which itself seems to be very similar to, or even identical,
to Skylake.

This is a superscalar microarch,
supporting speculative execution and register
renaming.
The pipeline has 14-19 stages.

The test system has 2x16 GB = 32 GB ddr4 memory:

```
        Size: 16 GB
        Form Factor: SODIMM
        Set: None
        Locator: ChannelB-DIMM0
        Bank Locator: BANK 2
        Type: DDR4
        Type Detail: Synchronous Unbuffered (Unregistered)
        Speed: 2400 MT/s
```

There is some run to run variablity in performance.
For `DIM=512` I see something like this:

```
OMP_NUM_THREADS=8 ./dgemm.x
     mm2d wtime     2.73438e-01
       mm wtime     2.10938e-01
   mmasmu wtime     5.46875e-02, which is 3.857143e+00 faster than mm version
    mmasm wtime     4.68750e-02, which is 4.500000e+00 faster than mm version
  mmasmlu wtime     3.12500e-02, which is 6.750000e+00 faster than mm version
     mmcb wtime     1.56250e-02, which is 1.350000e+01 faster than mm version
    mmomp wtime     5.18513e-03, which is 4.068126e+01 faster than mm version
```

Note that the unaligned asm version `mmasmu` is ~3.85x faster than
the serial version `mm`, while the theoretical speed-up from avx256 is 4x.
The aligned asm version `mmasm` is ~4.5x faster, i.e. higher than the
theoretical 4x, which probably means it probably achieves better cache reuse.
The most optimised version `mmomp` is ~40x faster than the naive version `mm`
for this matrix size..
The "most optimised" in this example means: x86 asm intrinsics for packed doubles,
loop unrolling, cache blocking and OpenMP threading.

For `DIM=1024` the max speed-up is nearly ~200x:

```
OMP_NUM_THREADS=8 ./dgemm.x
     mm2d wtime     9.10156e+00
       mm wtime     1.12422e+01
   mmasmu wtime     1.68750e+00, which is 6.662037e+00 faster than mm version
    mmasm wtime     1.67188e+00, which is 6.724299e+00 faster than mm version
  mmasmlu wtime     1.25000e+00, which is 8.993750e+00 faster than mm version
     mmcb wtime     1.79688e-01, which is 6.256522e+01 faster than mm version
    mmomp wtime     5.70140e-02, which is 1.971830e+02 faster than mm version
```

Note that adding just simd alone (`mmasmu` and `mmasm`) gives speed-up
significantly higher than the theoretical 4x.
Probably need to compare various cache hit/miss metrics, e.g. with `perf`.

For `DIM=2048` the max speed-up is above 200x:

```
OMP_NUM_THREADS=8 ./dgemm.x
     mm2d wtime     5.14766e+01
       mm wtime     1.30273e+02
   mmasmu wtime     3.13516e+01, which is 4.155245e+00 faster than mm version
    mmasm wtime     2.99453e+01, which is 4.350378e+00 faster than mm version
  mmasmlu wtime     1.03750e+01, which is 1.255648e+01 faster than mm version
     mmcb wtime     1.97656e+00, which is 6.590909e+01 faster than mm version
    mmomp wtime     5.79306e-01, which is 2.248784e+02 faster than mm version
```

and ~180x for `DIM=4096`:

```
OMP_NUM_THREADS=8 ./dgemm.x
     mm2d wtime     5.73609e+02
       mm wtime     1.04591e+03
   mmasmu wtime     2.50062e+02, which is 4.182579e+00 faster than mm version
    mmasm wtime     2.49906e+02, which is 4.185194e+00 faster than mm version
  mmasmlu wtime     9.50156e+01, which is 1.100773e+01 faster than mm version
     mmcb wtime     1.67109e+01, which is 6.258813e+01 faster than mm version
    mmomp wtime     5.74920e+00, which is 1.819219e+02 faster than mm version
```

# asm analysis

Note that my CPU does not support avx512, only avx256.

The several implementations are discussed in order of increasing optimisation.

## The naive 2D array code is in `mm.c`

The key fragment of the asm on my system is:
```
 37                                         # =>    This Inner Loop Header: Depth=3
 38         vmovsd  (%r8,%r10,8), %xmm1             # xmm1 = mem[0],zero
 39         movq    (%rdx,%r10,8), %r11
 40         vmulsd  (%r11,%r9,8), %xmm1, %xmm1
 41         vaddsd  %xmm0, %xmm1, %xmm0
 42         vmovsd  %xmm0, (%rcx,%r9,8)
 43         vmovsd  8(%r8,%r10,8), %xmm1            # xmm1 = mem[0],zero
 44         movq    8(%rdx,%r10,8), %r11
 45         vmulsd  (%r11,%r9,8), %xmm1, %xmm1
 46         vaddsd  %xmm0, %xmm1, %xmm0
 47         vmovsd  %xmm0, (%rcx,%r9,8)
```

which shows the use of 128-bit xmm registers,
and `sd` asm intrinsics i.e. only a single double
is loaded into the register, no vector operation.

## The naive 1D version, `mm1d.c`

The key asm fragment of the naive 1D version
is very similar to the 2D version:

```
110                                         # =>    This Inner Loop Header: Depth=3
111         vmovsd  -24(%r10,%r13,8), %xmm1         # xmm1 = mem[0],zero
112         vmulsd  (%rsi), %xmm1, %xmm1
113         vmovsd  -16(%r10,%r13,8), %xmm2         # xmm2 = mem[0],zero
114         vaddsd  %xmm0, %xmm1, %xmm0
115         vmulsd  (%rsi,%rax,8), %xmm2, %xmm1
116         vaddsd  %xmm0, %xmm1, %xmm0
117         vmovsd  -8(%r10,%r13,8), %xmm1          # xmm1 = mem[0],zero
118         vmulsd  (%rsi,%r15), %xmm1, %xmm1
119         vaddsd  %xmm0, %xmm1, %xmm0
120         vmovsd  (%r10,%r13,8), %xmm1            # xmm1 = mem[0],zero
121         vmulsd  (%rsi,%rbx), %xmm1, %xmm1
122         vaddsd  %xmm0, %xmm1, %xmm0
```

## Adding asm intrinsics, load/store are not aligned, `mmasmu.c`.

The unaligned load/store asm intrinsics are:
`_mm256_loadu_pd` and `_mm256_storeu_pd`.
The key fragment shows the use of ymm 256-bit registers
and `pd` versions of arm intrinsics, which operate
with packed doubles, i.e. 4x 64-bit doubles in
256-bit ymm registers.

Note that, in addition to the main loop, L88-101,
there is also the head and the tail code: 

``` 
 65 .LBB0_9:                                # %._crit_edge.us.us
 66                                         #   in Loop: Header=BB0_3 Depth=2
 67         vmovupd %ymm0, (%r15,%r13,8)
 68         addq    $4, %r13
 69         addq    $32, %rdx
 70         cmpq    %rax, %r13
 71         jae     .LBB0_10


 88 .LBB0_6:                                # %.preheader.us.us.new
 89                                         #   Parent Loop BB0_2 Depth=1
 90                                         #     Parent Loop BB0_3 Depth=2
 91                                         # =>    This Inner Loop Header: Depth=3
 92         vbroadcastsd    -8(%r11,%rbx,8), %ymm1
 93         vmulpd  (%r12), %ymm1, %ymm1
 94         vaddpd  %ymm1, %ymm0, %ymm0

 95         vbroadcastsd    (%r11,%rbx,8), %ymm1
 96         vmulpd  (%r12,%r9), %ymm1, %ymm1
 97         vaddpd  %ymm1, %ymm0, %ymm0

 98         addq    $2, %rbx
 99         addq    %r10, %r12
100         cmpq    %rbx, %r8
101         jne     .LBB0_6


106 # %bb.8:                                # %._crit_edge.us.us.epilog-lcssa
107                                         #   in Loop: Header=BB0_3 Depth=2
108         leaq    (%rcx,%r13,8), %r12
109         vbroadcastsd    (%r14,%rbx,8), %ymm1
110         imulq   %rax, %rbx
111         vmulpd  (%r12,%rbx,8), %ymm1, %ymm1
112         vaddpd  %ymm1, %ymm0, %ymm0
113         jmp     .LBB0_9
```

L67 in the head code saves the resulting data in array `c`:
```
 67         vmovupd %ymm0, (%r15,%r13,8)
```
Note that this is an unaligned load/store instruction.

The tail code is likely because the length of the
arrays, `n`, is passed to the function, and the compiler
cannot know if it is a factor of the vector length of not:
```
void mmasmu(int n, double* a, double* b, double* c);
```

Another interesting observation is that the compiler
seems to have auto unrolled by 2 -- L92-94 and L95-97
have vector bcast, mul and add operations at different
addresses of arrays `a` and `b`:
```
 10             __m256d tmp = _mm256_loadu_pd(b+k*n+j);
 11             tmp = _mm256_mul_pd(_mm256_broadcast_sd(a+i*n+k), tmp);
 12             c0 = _mm256_add_pd(c0, tmp);
 13          }
 14          _mm256_storeu_pd(c+i*n+j, c0);
```
L98 increments the loop counter by 2. 

So overall the code has 10 vector instructions:
3x bcast, 3x mul, 3x adds and 1x store.

Note that there is no `vmovupd` for a vector load of `b`
corresponding to `_mm256_loadu_pd(b+k*n+j)`.
Instead, what happens is this -- according to the amd64
calling convention the first 4 arguments are
passed in registers `rdi`, `rsi`, `rdx` and `rcx`:
https://gitlab.com/x86-psABIs/x86-64-ABI,
which for `mmasmu.c` are:
```
void mmasmu(int n, double* a, double* b, double* c)
```

So `rdx` has the address of array `b`.


To check that the tail code is due to compiler not
knowing the array length, I made a version of `mmasmu`
which takes the array length directly from `dgemm.h`:
```
  7 void mmasmu2(double* a, double* b, double* c)
  8 {
  9    for (int i=0; i<DIM; ++i)
 10       for (int j=0; j<DIM; j+=4) {
 11          __m256d c0 = _mm256_set1_pd(0.0);
 12          for (int k=0; k<DIM; ++k) {
```
and so on.

and indeed, this compiles to a much simpler asm:
```
 40 .LBB0_3:                                #   Parent Loop BB0_1 Depth=1
 41                                         #     Parent Loop BB0_2 Depth=2
 42                                         # =>    This Inner Loop Header: Depth=3
 43         vbroadcastsd    -8(%rdi,%r11,8), %ymm1
 44         vmulpd  -8192(%r10), %ymm1, %ymm1
 45         vaddpd  %ymm1, %ymm0, %ymm0
 46         vbroadcastsd    (%rdi,%r11,8), %ymm1
 47         vmulpd  (%r10), %ymm1, %ymm1
 48         vaddpd  %ymm1, %ymm0, %ymm0
 49         addq    $2, %r11
 50         addq    $16384, %r10                    # imm = 0x4000
 51         cmpq    $1024, %r11                     # imm = 0x400
 52         jne     .LBB0_3
 53 # %bb.4:                                #   in Loop: Header=BB0_2 Depth=2
 54         vmovupd %ymm0, (%rcx,%r9,8)
```

with only 2x bcast, 2x mul and 2x add vector calls.
The vector store is now in the tail code, L54.

Note also that L44,50-51 now have immediates,
not registers, because the compiler knows
all sizes.

Still, I can't see in the asm the
vector load of `b`.

## Same but with aligned load/store, `mmasm.c`.
