This example is motivated by sections "Going faster"
from Patterson and Hennessy "Computer Organization and Design".
I'm looking at 5th edition, from 2014.

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
 
