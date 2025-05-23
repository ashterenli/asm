	.text
	.file	"block.c"
                                        # Start of file scope inline assembly
.symver __qsort_r_compat, qsort_r@FBSD_1.0

                                        # End of file scope inline assembly
	.globl	block                           # -- Begin function block
	.p2align	4, 0x90
	.type	block,@function
block:                                  # @block
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
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
                                        # kill: def $esi killed $esi def $rsi
	movl	%edi, %r10d
	movq	16(%rbp), %rax
	movslq	%edx, %r14
	movslq	%ecx, %rdx
	movl	%edi, -44(%rbp)                 # 4-byte Spill
	movslq	%edi, %rcx
	movq	%rsi, %r10
	movq	%rsi, -56(%rbp)                 # 8-byte Spill
	movslq	%esi, %r10
	leal	31(%rdx), %esi
	movslq	%esi, %r11
	leal	31(%r10), %esi
	movslq	%esi, %rbx
	leaq	-1(%rdx), %rsi
	imulq	%rcx, %rdx
	movq	%r14, %rdi
	leaq	(,%r14,8), %r14
	leaq	(%r14,%rdx,8), %r14
	movq	%r10, %rdx
	imulq	%rcx, %rdx
	leaq	(%r8,%rdx,8), %r8
	leaq	(%r9,%r14), %rdx
	addq	$96, %rdx
	shlq	$3, %rcx
	addq	%r14, %r9
	addq	$224, %r9
	xorl	%r12d, %r12d
	.p2align	4, 0x90
.LBB0_1:                                # %.preheader47
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_2 Depth 2
                                        #     Child Loop BB0_4 Depth 2
	movq	-56(%rbp), %r14                 # 8-byte Reload
	addl	%r12d, %r14d
	imull	-44(%rbp), %r14d                # 4-byte Folded Reload
	movslq	%r14d, %r13
	addq	%rdi, %r13
	vmovapd	(%rax,%r13,8), %ymm3
	vmovapd	32(%rax,%r13,8), %ymm2
	vmovapd	64(%rax,%r13,8), %ymm1
	vmovapd	96(%rax,%r13,8), %ymm0
	movq	%rdx, %r15
	movq	%rsi, %r14
	.p2align	4, 0x90
.LBB0_2:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vbroadcastsd	8(%r8,%r14,8), %ymm4
	vmulpd	-96(%r15), %ymm4, %ymm5
	vaddpd	%ymm5, %ymm3, %ymm3
	vmulpd	-64(%r15), %ymm4, %ymm5
	vmulpd	-32(%r15), %ymm4, %ymm6
	vaddpd	%ymm5, %ymm2, %ymm2
	vaddpd	%ymm6, %ymm1, %ymm1
	vmulpd	(%r15), %ymm4, %ymm4
	vaddpd	%ymm4, %ymm0, %ymm0
	incq	%r14
	addq	%rcx, %r15
	cmpq	%r11, %r14
	jl	.LBB0_2
# %bb.3:                                # %.preheader46.1
                                        #   in Loop: Header=BB0_1 Depth=1
	vmovapd	%ymm3, (%rax,%r13,8)
	vmovapd	%ymm2, 32(%rax,%r13,8)
	vmovapd	%ymm1, 64(%rax,%r13,8)
	vmovapd	%ymm0, 96(%rax,%r13,8)
	vmovapd	128(%rax,%r13,8), %ymm3
	vmovapd	160(%rax,%r13,8), %ymm2
	vmovapd	192(%rax,%r13,8), %ymm1
	vmovapd	224(%rax,%r13,8), %ymm0
	movq	%r9, %r14
	movq	%rsi, %r15
	.p2align	4, 0x90
.LBB0_4:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vbroadcastsd	8(%r8,%r15,8), %ymm4
	vmulpd	-96(%r14), %ymm4, %ymm5
	vaddpd	%ymm5, %ymm3, %ymm3
	vmulpd	-64(%r14), %ymm4, %ymm5
	vmulpd	-32(%r14), %ymm4, %ymm6
	vaddpd	%ymm5, %ymm2, %ymm2
	vaddpd	%ymm6, %ymm1, %ymm1
	vmulpd	(%r14), %ymm4, %ymm4
	vaddpd	%ymm4, %ymm0, %ymm0
	incq	%r15
	addq	%rcx, %r14
	cmpq	%r11, %r15
	jl	.LBB0_4
# %bb.5:                                #   in Loop: Header=BB0_1 Depth=1
	vmovapd	%ymm3, 128(%rax,%r13,8)
	vmovapd	%ymm2, 160(%rax,%r13,8)
	vmovapd	%ymm1, 192(%rax,%r13,8)
	vmovapd	%ymm0, 224(%rax,%r13,8)
	leaq	1(%r10), %r14
	incq	%r12
	addq	%rcx, %r8
	cmpq	%rbx, %r10
	movq	%r14, %r10
	jl	.LBB0_1
# %bb.6:
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	vzeroupper
	retq
.Lfunc_end0:
	.size	block, .Lfunc_end0-block
	.cfi_endproc
                                        # -- End function
	.ident	"FreeBSD clang version 18.1.6 (https://github.com/llvm/llvm-project.git llvmorg-18.1.6-0-g1118c2e05e67)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
