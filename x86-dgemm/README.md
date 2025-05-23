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

The test system and 2x16 GB = 32 GB ddr4 memory:

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

``` 
 91                                         # =>    This Inner Loop Header: Depth=3
 92         vbroadcastsd    -8(%r11,%rbx,8), %ymm1
 93         vmulpd  (%r12), %ymm1, %ymm1
 94         vaddpd  %ymm1, %ymm0, %ymm0
 95         vbroadcastsd    (%r11,%rbx,8), %ymm1
 96         vmulpd  (%r12,%r9), %ymm1, %ymm1
 97         vaddpd  %ymm1, %ymm0, %ymm0
```

Note 2x broadcasts, 2x multiplications and 2x adds.

## Same but with aligned load/store, `mmasm.c`.
