HEAD=	dgemm.h
SRC=	mm2d.c mm.c mmasmu.c mmasmu2.c mmasm.c mmasmlu.c block.c mmcb.c mmomp.c dgemm.c
OBJ=	$(SRC:.c=.o)
TMP=	$(SRC:.c=.bc) $(SRC:.c=.i) $(SRC:.c=.s)
EXE=	dgemm.x

CFLAGS=	-g -Wall -O3 -mavx2 -fopenmp -save-temps

all:	$(EXE)

$(OBJ):	$(HEAD) Makefile

$(EXE):	$(OBJ)
	$(CC) $(CFLAGS) -o $(EXE) $(OBJ)

run:	
	OMP_NUM_THREADS=8 ./$(EXE)

clean:
	rm -f $(OBJ) $(TMP) $(EXE)
