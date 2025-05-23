	.text
	.file	"dgemm.c"
                                        # Start of file scope inline assembly
.symver __qsort_r_compat, qsort_r@FBSD_1.0

                                        # End of file scope inline assembly
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function main
.LCPI0_0:
	.quad	0x3ff0000000000000              # double 1
.LCPI0_3:
	.quad	0x3ddb7cdfd9d7bdbb              # double 1.0E-10
.LCPI0_4:
	.quad	0x7fffffffffffffff              # double NaN
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI0_1:
	.long	0x3c000000                      # float 0.0078125
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI0_2:
	.quad	0x7fffffffffffffff              # double NaN
	.quad	0x7fffffffffffffff              # double NaN
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24792, %rsp                    # imm = 0x60D8
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	movl	$8192, %edi                     # imm = 0x2000
	callq	malloc
	movq	%rax, -24800(%rbp,%rbx,8)
	movl	$8192, %edi                     # imm = 0x2000
	callq	malloc
	movq	%rax, -16608(%rbp,%rbx,8)
	movl	$8192, %edi                     # imm = 0x2000
	callq	malloc
	movq	%rax, -8416(%rbp,%rbx,8)
	incq	%rbx
	cmpq	$1024, %rbx                     # imm = 0x400
	jne	.LBB0_1
# %bb.2:
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rax, %rbx
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rax, %r13
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rax, -160(%rbp)                # 8-byte Spill
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rax, %r12
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rax, -152(%rbp)                # 8-byte Spill
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rax, -136(%rbp)                # 8-byte Spill
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rax, -128(%rbp)                # 8-byte Spill
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rax, %r14
	movl	$8388608, %edi                  # imm = 0x800000
	callq	malloc
	movq	%rax, %r15
	xorl	%edi, %edi
	callq	time
	movl	%eax, %edi
	callq	srand
	movq	%r13, %rax
	subq	%rbx, %rax
	movq	%rax, -208(%rbp)                # 8-byte Spill
	movq	%r14, %rax
	subq	%rbx, %rax
	movq	%rax, -200(%rbp)                # 8-byte Spill
	movq	%r15, %rax
	subq	%rbx, %rax
	movq	%rax, -192(%rbp)                # 8-byte Spill
	movq	%r14, %rax
	subq	%r13, %rax
	movq	%rax, -184(%rbp)                # 8-byte Spill
	movq	%r15, %rax
	subq	%r13, %rax
	movq	%rax, -176(%rbp)                # 8-byte Spill
	movq	%r15, %rax
	subq	%r14, %rax
	movq	%rax, -168(%rbp)                # 8-byte Spill
	leaq	96(%r15), %r9
	leaq	96(%r14), %r10
	leaq	96(%r13), %r11
	leaq	96(%rbx), %r8
	movabsq	$4607182418800017408, %rax      # imm = 0x3FF0000000000000
	vbroadcastsd	.LCPI0_0(%rip), %ymm0   # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
	vxorps	%xmm1, %xmm1, %xmm1
	movq	%rbx, -80(%rbp)                 # 8-byte Spill
	movq	%r13, %rcx
	movq	%r13, -88(%rbp)                 # 8-byte Spill
	movq	%r13, -48(%rbp)                 # 8-byte Spill
	movq	%r14, %rcx
	movq	%r14, -96(%rbp)                 # 8-byte Spill
	movq	%r14, -64(%rbp)                 # 8-byte Spill
	xorl	%r14d, %r14d
	movq	%r15, -144(%rbp)                # 8-byte Spill
	movq	%r15, %rsi
	jmp	.LBB0_3
	.p2align	4, 0x90
.LBB0_22:                               # %middle.block
                                        #   in Loop: Header=BB0_3 Depth=1
	movq	%r14, %rdx
	movq	-216(%rbp), %r14                # 8-byte Reload
	incq	%r14
	addq	$8192, %r9                      # imm = 0x2000
	addq	$8192, %r10                     # imm = 0x2000
	addq	$8192, %r11                     # imm = 0x2000
	addq	$8192, %r8                      # imm = 0x2000
	addq	$8192, %rsi                     # imm = 0x2000
	addq	$8192, -64(%rbp)                # 8-byte Folded Spill
                                        # imm = 0x2000
	addq	$8192, %rdx                     # imm = 0x2000
	movq	%rdx, -48(%rbp)                 # 8-byte Spill
	addq	$8192, %rcx                     # imm = 0x2000
	movq	%rcx, -80(%rbp)                 # 8-byte Spill
	cmpq	$1024, %r14                     # imm = 0x400
	je	.LBB0_23
.LBB0_3:                                # %.preheader129
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_19 Depth 2
                                        #     Child Loop BB0_21 Depth 2
	movq	-24800(%rbp,%r14,8), %rdx
	movq	-16608(%rbp,%r14,8), %r15
	movq	%r14, -216(%rbp)                # 8-byte Spill
	shlq	$13, %r14
	movq	%r14, %rcx
	negq	%rcx
	movq	%rcx, %rdi
	subq	%rbx, %rdi
	leaq	(%rdi,%rdx), %r13
	cmpq	$128, %r13
	jb	.LBB0_20
# %bb.4:                                # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	cmpq	$128, -208(%rbp)                # 8-byte Folded Reload
	jb	.LBB0_20
# %bb.5:                                # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	addq	%r15, %rdi
	cmpq	$128, %rdi
	jb	.LBB0_20
# %bb.6:                                # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	cmpq	$128, -200(%rbp)                # 8-byte Folded Reload
	jb	.LBB0_20
# %bb.7:                                # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	cmpq	$128, -192(%rbp)                # 8-byte Folded Reload
	jb	.LBB0_20
# %bb.8:                                # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	movq	-88(%rbp), %rdi                 # 8-byte Reload
	addq	%r14, %rdi
	subq	%rdx, %rdi
	cmpq	$128, %rdi
	jb	.LBB0_20
# %bb.9:                                # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	movq	%r15, %rdi
	subq	%rdx, %rdi
	cmpq	$128, %rdi
	jb	.LBB0_20
# %bb.10:                               # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	movq	-96(%rbp), %rdi                 # 8-byte Reload
	leaq	(%r14,%rdi), %r13
	movq	%r13, %rdi
	subq	%rdx, %rdi
	cmpq	$128, %rdi
	jb	.LBB0_20
# %bb.11:                               # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	addq	-144(%rbp), %r14                # 8-byte Folded Reload
	movq	%r14, %rdi
	subq	%rdx, %rdi
	cmpq	$128, %rdi
	jb	.LBB0_20
# %bb.12:                               # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	subq	-88(%rbp), %rcx                 # 8-byte Folded Reload
	addq	%r15, %rcx
	cmpq	$128, %rcx
	jb	.LBB0_20
# %bb.13:                               # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	cmpq	$128, -184(%rbp)                # 8-byte Folded Reload
	jb	.LBB0_20
# %bb.14:                               # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	cmpq	$128, -176(%rbp)                # 8-byte Folded Reload
	jb	.LBB0_20
# %bb.15:                               # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	subq	%r15, %r13
	cmpq	$128, %r13
	jb	.LBB0_20
# %bb.16:                               # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	subq	%r15, %r14
	cmpq	$128, %r14
	jb	.LBB0_20
# %bb.17:                               # %.preheader129
                                        #   in Loop: Header=BB0_3 Depth=1
	cmpq	$128, -168(%rbp)                # 8-byte Folded Reload
	jb	.LBB0_20
# %bb.18:                               # %vector.body.preheader
                                        #   in Loop: Header=BB0_3 Depth=1
	xorl	%edi, %edi
	movq	-80(%rbp), %rcx                 # 8-byte Reload
	movq	-48(%rbp), %r14                 # 8-byte Reload
	.p2align	4, 0x90
.LBB0_19:                               # %vector.body
                                        #   Parent Loop BB0_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%ymm0, -96(%r8,%rdi)
	vmovupd	%ymm0, -64(%r8,%rdi)
	vmovupd	%ymm0, -32(%r8,%rdi)
	vmovupd	%ymm0, (%r8,%rdi)
	vmovupd	%ymm0, (%rdx,%rdi)
	vmovupd	%ymm0, 32(%rdx,%rdi)
	vmovupd	%ymm0, 64(%rdx,%rdi)
	vmovupd	%ymm0, 96(%rdx,%rdi)
	vmovupd	%ymm0, -96(%r11,%rdi)
	vmovupd	%ymm0, -64(%r11,%rdi)
	vmovupd	%ymm0, -32(%r11,%rdi)
	vmovupd	%ymm0, (%r11,%rdi)
	vmovupd	%ymm0, (%r15,%rdi)
	vmovupd	%ymm0, 32(%r15,%rdi)
	vmovupd	%ymm0, 64(%r15,%rdi)
	vmovupd	%ymm0, 96(%r15,%rdi)
	vmovups	%ymm1, -96(%r10,%rdi)
	vmovups	%ymm1, -64(%r10,%rdi)
	vmovups	%ymm1, -32(%r10,%rdi)
	vmovups	%ymm1, (%r10,%rdi)
	vmovups	%ymm1, -96(%r9,%rdi)
	vmovups	%ymm1, -64(%r9,%rdi)
	vmovups	%ymm1, -32(%r9,%rdi)
	vmovups	%ymm1, (%r9,%rdi)
	subq	$-128, %rdi
	cmpq	$8192, %rdi                     # imm = 0x2000
	jne	.LBB0_19
	jmp	.LBB0_22
	.p2align	4, 0x90
.LBB0_20:                               # %scalar.ph.preheader
                                        #   in Loop: Header=BB0_3 Depth=1
	xorl	%edi, %edi
	movq	-80(%rbp), %rcx                 # 8-byte Reload
	movq	-48(%rbp), %r14                 # 8-byte Reload
	.p2align	4, 0x90
.LBB0_21:                               # %scalar.ph
                                        #   Parent Loop BB0_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rax, (%rcx,%rdi)
	movq	%rax, (%rdx,%rdi)
	movq	%rax, (%r14,%rdi)
	movq	%rax, (%r15,%rdi)
	movq	-64(%rbp), %r13                 # 8-byte Reload
	movq	$0, (%r13,%rdi)
	movq	$0, (%rsi,%rdi)
	addq	$8, %rdi
	cmpq	$8192, %rdi                     # imm = 0x2000
	jne	.LBB0_21
	jmp	.LBB0_22
.LBB0_23:
	vzeroupper
	callq	clock
	movl	%eax, %r14d
	leaq	-8416(%rbp), %rdi
	leaq	-24800(%rbp), %rsi
	leaq	-16608(%rbp), %rdx
	callq	mm2d
	callq	clock
	subl	%r14d, %eax
	movl	%eax, -100(%rbp)
	flds	.LCPI0_1(%rip)
	fld	%st(0)
	fstpt	-64(%rbp)                       # 10-byte Folded Spill
	fimull	-100(%rbp)
	fstpt	(%rsp)
	movl	$.L.str, %edi
	movl	$.L.str.1, %esi
	xorl	%eax, %eax
	callq	printf
	callq	clock
	movl	%eax, %r15d
	movl	$1024, %edi                     # imm = 0x400
	movq	%rbx, %rsi
	movq	-88(%rbp), %r13                 # 8-byte Reload
	movq	%r13, %rdx
	movq	-160(%rbp), %r14                # 8-byte Reload
	movq	%r14, %rcx
	callq	mm
	callq	clock
	subl	%r15d, %eax
	movl	%eax, -104(%rbp)
	fldt	-64(%rbp)                       # 10-byte Folded Reload
	fimull	-104(%rbp)
	fld	%st(0)
	fstpt	-80(%rbp)                       # 10-byte Folded Spill
	fstpt	(%rsp)
	movl	$.L.str, %edi
	movl	$.L.str.2, %esi
	xorl	%eax, %eax
	callq	printf
	callq	clock
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movl	$1024, %edi                     # imm = 0x400
	movq	%rbx, %rsi
	movq	%r13, %rdx
	movq	-152(%rbp), %r15                # 8-byte Reload
	movq	%r15, %rcx
	callq	mmasmu
	callq	clock
	subl	-48(%rbp), %eax                 # 4-byte Folded Reload
	movl	%eax, -108(%rbp)
	fldt	-64(%rbp)                       # 10-byte Folded Reload
	fimull	-108(%rbp)
	fldt	-80(%rbp)                       # 10-byte Folded Reload
	fdiv	%st(1), %st
	fxch	%st(1)
	fstpt	(%rsp)
	fstpt	16(%rsp)
	movl	$.L.str.3, %edi
	movl	$.L.str.4, %esi
	xorl	%eax, %eax
	callq	printf
	callq	clock
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movl	$1024, %edi                     # imm = 0x400
	movq	%rbx, %rsi
	movq	%r13, %rdx
	movq	-136(%rbp), %rcx                # 8-byte Reload
	callq	mmasm
	callq	clock
	subl	-48(%rbp), %eax                 # 4-byte Folded Reload
	movl	%eax, -112(%rbp)
	fldt	-64(%rbp)                       # 10-byte Folded Reload
	fimull	-112(%rbp)
	fldt	-80(%rbp)                       # 10-byte Folded Reload
	fdiv	%st(1), %st
	fxch	%st(1)
	fstpt	(%rsp)
	fstpt	16(%rsp)
	movl	$.L.str.3, %edi
	movl	$.L.str.5, %esi
	xorl	%eax, %eax
	callq	printf
	callq	clock
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movl	$1024, %edi                     # imm = 0x400
	movq	%rbx, %rsi
	movq	%r13, %rdx
	movq	-128(%rbp), %rcx                # 8-byte Reload
	callq	mmasmlu
	callq	clock
	subl	-48(%rbp), %eax                 # 4-byte Folded Reload
	movl	%eax, -116(%rbp)
	fldt	-64(%rbp)                       # 10-byte Folded Reload
	fimull	-116(%rbp)
	fldt	-80(%rbp)                       # 10-byte Folded Reload
	fdiv	%st(1), %st
	fxch	%st(1)
	fstpt	(%rsp)
	fstpt	16(%rsp)
	movl	$.L.str.3, %edi
	movl	$.L.str.6, %esi
	xorl	%eax, %eax
	callq	printf
	callq	clock
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movl	$1024, %edi                     # imm = 0x400
	movq	%rbx, %rsi
	movq	%r13, %rdx
	movq	-96(%rbp), %rcx                 # 8-byte Reload
	callq	mmcb
	callq	clock
	subl	-48(%rbp), %eax                 # 4-byte Folded Reload
	movl	%eax, -120(%rbp)
	fldt	-64(%rbp)                       # 10-byte Folded Reload
	fimull	-120(%rbp)
	fldt	-80(%rbp)                       # 10-byte Folded Reload
	fdiv	%st(1), %st
	fxch	%st(1)
	fstpt	(%rsp)
	fstpt	16(%rsp)
	movl	$.L.str.3, %edi
	movl	$.L.str.7, %esi
	xorl	%eax, %eax
	callq	printf
	callq	omp_get_wtime
	vmovsd	%xmm0, -64(%rbp)                # 8-byte Spill
	movl	$1024, %edi                     # imm = 0x400
	movq	%rbx, %rsi
	movq	%r13, %rdx
	movq	-144(%rbp), %rcx                # 8-byte Reload
	callq	mmomp
	callq	omp_get_wtime
	vsubsd	-64(%rbp), %xmm0, %xmm0         # 8-byte Folded Reload
	vmovsd	%xmm0, -224(%rbp)
	fldl	-224(%rbp)
	fldt	-80(%rbp)                       # 10-byte Folded Reload
	fdiv	%st(1), %st
	fxch	%st(1)
	fstpt	(%rsp)
	fstpt	16(%rsp)
	movl	$.L.str.3, %edi
	movl	$.L.str.8, %esi
	xorl	%eax, %eax
	callq	printf
	xorl	%ecx, %ecx
	movq	-128(%rbp), %r11                # 8-byte Reload
	movq	-136(%rbp), %r10                # 8-byte Reload
	addq	$8, %rbx
	addq	$8192, %r13                     # imm = 0x2000
	movq	%r13, -88(%rbp)                 # 8-byte Spill
	vmovddup	.LCPI0_4(%rip), %xmm0           # xmm0 = [NaN,NaN]
                                        # xmm0 = mem[0,0]
	vmovsd	.LCPI0_3(%rip), %xmm1           # xmm1 = [1.0E-10,0.0E+0]
	.p2align	4, 0x90
.LBB0_24:                               # %.preheader128
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_26 Depth 2
                                        #       Child Loop BB0_27 Depth 3
	movq	%rcx, %rax
	shlq	$10, %rax
	movq	%rcx, %r13
	movq	-8416(%rbp,%rcx,8), %rcx
	movq	-88(%rbp), %rdx                 # 8-byte Reload
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB0_26:                               # %.preheader
                                        #   Parent Loop BB0_24 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_27 Depth 3
	movq	%rsi, %rdi
	orq	%rax, %rdi
	vmovsd	(%r12,%rdi,8), %xmm2            # xmm2 = mem[0],zero
	movq	%rdx, %r8
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB0_27:                               #   Parent Loop BB0_24 Depth=1
                                        #     Parent Loop BB0_26 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovsd	-8(%rbx,%r9,8), %xmm3           # xmm3 = mem[0],zero
	vmulsd	-8192(%r8), %xmm3, %xmm3
	vmovsd	(%rbx,%r9,8), %xmm4             # xmm4 = mem[0],zero
	vaddsd	%xmm2, %xmm3, %xmm2
	vmulsd	(%r8), %xmm4, %xmm3
	vaddsd	%xmm2, %xmm3, %xmm2
	addq	$2, %r9
	addq	$16384, %r8                     # imm = 0x4000
	cmpq	$1024, %r9                      # imm = 0x400
	jne	.LBB0_27
# %bb.28:                               #   in Loop: Header=BB0_26 Depth=2
	vmovsd	%xmm2, (%r12,%rdi,8)
	vmovsd	(%rcx,%rsi,8), %xmm3            # xmm3 = mem[0],zero
	leaq	(%rsi,%rax), %rdi
	vmovsd	(%r12,%rdi,8), %xmm2            # xmm2 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm3
	vandpd	%xmm0, %xmm3, %xmm3
	vucomisd	%xmm3, %xmm1
	jbe	.LBB0_37
# %bb.29:                               #   in Loop: Header=BB0_26 Depth=2
	vmovsd	(%r14,%rdi,8), %xmm3            # xmm3 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm3
	vandpd	%xmm0, %xmm3, %xmm3
	vucomisd	%xmm3, %xmm1
	jbe	.LBB0_38
# %bb.30:                               #   in Loop: Header=BB0_26 Depth=2
	vmovsd	(%r15,%rdi,8), %xmm3            # xmm3 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm3
	vandpd	%xmm0, %xmm3, %xmm3
	vucomisd	%xmm3, %xmm1
	jbe	.LBB0_39
# %bb.31:                               #   in Loop: Header=BB0_26 Depth=2
	vmovsd	(%r10,%rdi,8), %xmm3            # xmm3 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm3
	vandpd	%xmm0, %xmm3, %xmm3
	vucomisd	%xmm3, %xmm1
	jbe	.LBB0_40
# %bb.32:                               #   in Loop: Header=BB0_26 Depth=2
	vmovsd	(%r11,%rdi,8), %xmm3            # xmm3 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm3
	vandpd	%xmm0, %xmm3, %xmm3
	vucomisd	%xmm3, %xmm1
	jbe	.LBB0_41
# %bb.33:                               #   in Loop: Header=BB0_26 Depth=2
	movq	-96(%rbp), %r8                  # 8-byte Reload
	vmovsd	(%r8,%rdi,8), %xmm3             # xmm3 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm2
	vandpd	%xmm0, %xmm2, %xmm2
	vucomisd	%xmm2, %xmm1
	jbe	.LBB0_34
# %bb.25:                               #   in Loop: Header=BB0_26 Depth=2
	incq	%rsi
	addq	$8, %rdx
	cmpq	$1024, %rsi                     # imm = 0x400
	jne	.LBB0_26
# %bb.35:                               #   in Loop: Header=BB0_24 Depth=1
	movq	%r13, %rcx
	incq	%rcx
	addq	$8192, %rbx                     # imm = 0x2000
	cmpq	$1024, %rcx                     # imm = 0x400
	jne	.LBB0_24
# %bb.36:
	xorl	%eax, %eax
	addq	$24792, %rsp                    # imm = 0x60D8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB0_37:
	.cfi_def_cfa %rbp, 16
	movl	$.L__func__.main, %edi
	movl	$.L.str.9, %esi
	movl	$.L.str.10, %ecx
	movl	$98, %edx
	callq	__assert
.LBB0_38:
	movl	$.L__func__.main, %edi
	movl	$.L.str.9, %esi
	movl	$.L.str.11, %ecx
	movl	$99, %edx
	callq	__assert
.LBB0_39:
	movl	$.L__func__.main, %edi
	movl	$.L.str.9, %esi
	movl	$.L.str.12, %ecx
	movl	$100, %edx
	callq	__assert
.LBB0_40:
	movl	$.L__func__.main, %edi
	movl	$.L.str.9, %esi
	movl	$.L.str.13, %ecx
	movl	$101, %edx
	callq	__assert
.LBB0_41:
	movl	$.L__func__.main, %edi
	movl	$.L.str.9, %esi
	movl	$.L.str.14, %ecx
	movl	$102, %edx
	callq	__assert
.LBB0_34:
	movl	$.L__func__.main, %edi
	movl	$.L.str.9, %esi
	movl	$.L.str.15, %ecx
	movl	$103, %edx
	callq	__assert
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%15s %15.5Le\n"
	.size	.L.str, 14

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"mm2d wtime"
	.size	.L.str.1, 11

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"mm wtime"
	.size	.L.str.2, 9

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"%15s %15.5Le, which is %10Le faster than mm version\n"
	.size	.L.str.3, 53

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"mmasmu wtime"
	.size	.L.str.4, 13

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"mmasm wtime"
	.size	.L.str.5, 12

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"mmasmlu wtime"
	.size	.L.str.6, 14

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"mmcb wtime"
	.size	.L.str.7, 11

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"mmomp wtime"
	.size	.L.str.8, 12

	.type	.L__func__.main,@object         # @__func__.main
.L__func__.main:
	.asciz	"main"
	.size	.L__func__.main, 5

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"dgemm.c"
	.size	.L.str.9, 8

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"fabs(c[i][j] - c1ref[i*DIM + j]) < TOL"
	.size	.L.str.10, 39

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"fabs(c1[i*DIM + j] - c1ref[i*DIM + j]) < TOL"
	.size	.L.str.11, 45

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"fabs(c2[i*DIM + j] - c1ref[i*DIM + j]) < TOL"
	.size	.L.str.12, 45

	.type	.L.str.13,@object               # @.str.13
.L.str.13:
	.asciz	"fabs(c3[i*DIM + j] - c1ref[i*DIM + j]) < TOL"
	.size	.L.str.13, 45

	.type	.L.str.14,@object               # @.str.14
.L.str.14:
	.asciz	"fabs(c4[i*DIM + j] - c1ref[i*DIM + j]) < TOL"
	.size	.L.str.14, 45

	.type	.L.str.15,@object               # @.str.15
.L.str.15:
	.asciz	"fabs(c5[i*DIM + j] - c1ref[i*DIM + j]) < TOL"
	.size	.L.str.15, 45

	.ident	"FreeBSD clang version 18.1.6 (https://github.com/llvm/llvm-project.git llvmorg-18.1.6-0-g1118c2e05e67)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
