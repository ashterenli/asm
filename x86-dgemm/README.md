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

Running on FreeBSD 14-2 laptop with:

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

and 2x16 GB = 32 GB ddr4 memory:

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

I see these run times:

```
OMP_NUM_THREADS=8 ./dgemm.x
                 mm wtime     8.5546875000e+00
               mm1d wtime     8.4453125000e+00, which is 1.012951e+00 faster than initial version
             mmasmu wtime     1.7109375000e+00, which is 5.000000e+00 faster than initial version
              mmasm wtime     1.7187500000e+00, which is 4.977273e+00 faster than initial version
            mmasmlu wtime     1.3046875000e+00, which is 6.556886e+00 faster than initial version
               mmcb wtime     1.7187500000e-01, which is 4.977273e+01 faster than initial version
              mmomp wtime     6.0064077377e-02, which is 1.424260e+02 faster than initial version
```

i.e. the best version is ~140x faster than the initial naive version.
The fastest version uses x86 asm intrinsics for packed doubles,
loop unrolling, cache blocking and OpenMP threading.

For `DIM=2048` the max speed-up is ~80x:
```
OMP_NUM_THREADS=8 ./dgemm.x
                 mm wtime     4.9789062500e+01
               mm1d wtime     1.2723437500e+02, which is 3.913177e-01 faster than initial version
             mmasmu wtime     2.9500000000e+01, which is 1.687765e+00 faster than initial version
              mmasm wtime     2.9070312500e+01, which is 1.712712e+00 faster than initial version
            mmasmlu wtime     1.0625000000e+01, which is 4.686029e+00 faster than initial version
               mmcb wtime     1.9531250000e+00, which is 2.549200e+01 faster than initial version
              mmomp wtime     5.9656906128e-01, which is 8.345901e+01 faster than initial version
```

# asm analysis

Note that my CPU does not support avx512, only avx256.

In order from progressive optimisation, the naive
2D array code is in `mm.c`.
The key fragment of the resulting asm on my system is:
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

The key asm fragment of the naive 1D version, `mm1d.c`,
is very similar:

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

The next version is `mmasmu.c`, which uses
the unaligned load/store asm intrinsics.
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

