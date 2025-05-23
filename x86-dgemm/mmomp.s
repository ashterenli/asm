	.text
	.file	"mmomp.c"
                                        # Start of file scope inline assembly
.symver __qsort_r_compat, qsort_r@FBSD_1.0

                                        # End of file scope inline assembly
	.globl	mmomp                           # -- Begin function mmomp
	.p2align	4, 0x90
	.type	mmomp,@function
mmomp:                                  # @mmomp
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -16(%rbp)
	leaq	-16(%rbp), %rax
	movq	%rax, (%rsp)
	leaq	-4(%rbp), %rcx
	leaq	-32(%rbp), %r8
	leaq	-24(%rbp), %r9
	movl	$.L__unnamed_1, %edi
	movl	$mmomp.omp_outlined, %edx
	movl	$4, %esi
	xorl	%eax, %eax
	callq	__kmpc_fork_call@PLT
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	mmomp, .Lfunc_end0-mmomp
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function mmomp.omp_outlined
	.type	mmomp.omp_outlined,@function
mmomp.omp_outlined:                     # @mmomp.omp_outlined
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
	subq	$56, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movl	(%rdx), %ebx
	testl	%ebx, %ebx
	jle	.LBB1_14
# %bb.1:
	movq	%rcx, -80(%rbp)                 # 8-byte Spill
	movq	%r8, -88(%rbp)                  # 8-byte Spill
	movq	%r9, -96(%rbp)                  # 8-byte Spill
	addl	$31, %ebx
	shrl	$5, %ebx
	decl	%ebx
	movl	$0, -48(%rbp)
	movl	%ebx, -44(%rbp)
	movl	$1, -64(%rbp)
	movl	$0, -60(%rbp)
	movl	(%rdi), %esi
	subq	$8, %rsp
	leaq	-64(%rbp), %rax
	leaq	-60(%rbp), %rcx
	leaq	-48(%rbp), %r8
	leaq	-44(%rbp), %r9
	movl	$.L__unnamed_2, %edi
	movl	%esi, -52(%rbp)                 # 4-byte Spill
	movq	%rdx, -72(%rbp)                 # 8-byte Spill
	movl	$34, %edx
	pushq	$1
	pushq	$1
	pushq	%rax
	callq	__kmpc_for_static_init_4u@PLT
	movq	-72(%rbp), %rcx                 # 8-byte Reload
	addq	$32, %rsp
	movl	-44(%rbp), %eax
	cmpl	%ebx, %eax
	cmovbl	%eax, %ebx
	movl	%ebx, -44(%rbp)
	movl	-48(%rbp), %edx
	cmpl	%ebx, %edx
	ja	.LBB1_13
# %bb.2:
	movl	(%rcx), %edi
	testl	%edi, %edi
	jle	.LBB1_13
# %bb.3:                                # %.lr.ph28.split.preheader
	movq	-96(%rbp), %r12                 # 8-byte Reload
	movq	-88(%rbp), %r13                 # 8-byte Reload
	jmp	.LBB1_4
	.p2align	4, 0x90
.LBB1_11:                               # %._crit_edge25.loopexit
                                        #   in Loop: Header=BB1_4 Depth=1
	movl	-44(%rbp), %ebx
	movl	-56(%rbp), %edx                 # 4-byte Reload
.LBB1_12:                               # %._crit_edge25
                                        #   in Loop: Header=BB1_4 Depth=1
	incl	%edx
	leal	1(%rbx), %eax
	cmpl	%eax, %edx
	jae	.LBB1_13
.LBB1_4:                                # %.lr.ph28.split
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_7 Depth 2
                                        #       Child Loop BB1_9 Depth 3
	testl	%edi, %edi
	jle	.LBB1_12
# %bb.5:                                # %.preheader.lr.ph
                                        #   in Loop: Header=BB1_4 Depth=1
	testl	%edi, %edi
	jle	.LBB1_12
# %bb.6:                                # %.preheader.preheader
                                        #   in Loop: Header=BB1_4 Depth=1
	movl	%edx, -56(%rbp)                 # 4-byte Spill
	movl	%edx, %ebx
	shll	$5, %ebx
	xorl	%r15d, %r15d
	jmp	.LBB1_7
	.p2align	4, 0x90
.LBB1_10:                               # %._crit_edge
                                        #   in Loop: Header=BB1_7 Depth=2
	addl	$32, %r15d
	cmpl	%edi, %r15d
	jge	.LBB1_11
.LBB1_7:                                # %.preheader
                                        #   Parent Loop BB1_4 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_9 Depth 3
	testl	%edi, %edi
	movq	-80(%rbp), %rdx                 # 8-byte Reload
	jle	.LBB1_10
# %bb.8:                                # %.lr.ph.preheader
                                        #   in Loop: Header=BB1_7 Depth=2
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB1_9:                                # %.lr.ph
                                        #   Parent Loop BB1_4 Depth=1
                                        #     Parent Loop BB1_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	(%rdx), %r8
	movq	(%r13), %r9
	subq	$8, %rsp
	movl	%ebx, %esi
	movl	%r15d, %edx
	movl	%r14d, %ecx
	pushq	(%r12)
	callq	block
	movq	-80(%rbp), %rdx                 # 8-byte Reload
	addq	$16, %rsp
	addl	$32, %r14d
	movq	-72(%rbp), %rax                 # 8-byte Reload
	movl	(%rax), %edi
	cmpl	%edi, %r14d
	jl	.LBB1_9
	jmp	.LBB1_10
.LBB1_13:                               # %._crit_edge29
	movl	$.L__unnamed_2, %edi
	movl	-52(%rbp), %esi                 # 4-byte Reload
	callq	__kmpc_for_static_fini@PLT
.LBB1_14:
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	mmomp.omp_outlined, .Lfunc_end1-mmomp.omp_outlined
	.cfi_endproc
                                        # -- End function
	.type	.L__unnamed_3,@object           # @0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__unnamed_3:
	.asciz	";unknown;unknown;0;0;;"
	.size	.L__unnamed_3, 23

	.type	.L__unnamed_2,@object           # @1
	.section	.rodata,"a",@progbits
	.p2align	3, 0x0
.L__unnamed_2:
	.long	0                               # 0x0
	.long	514                             # 0x202
	.long	0                               # 0x0
	.long	22                              # 0x16
	.quad	.L__unnamed_3
	.size	.L__unnamed_2, 24

	.type	.L__unnamed_1,@object           # @2
	.p2align	3, 0x0
.L__unnamed_1:
	.long	0                               # 0x0
	.long	2                               # 0x2
	.long	0                               # 0x0
	.long	22                              # 0x16
	.quad	.L__unnamed_3
	.size	.L__unnamed_1, 24

	.ident	"FreeBSD clang version 18.1.6 (https://github.com/llvm/llvm-project.git llvmorg-18.1.6-0-g1118c2e05e67)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym mmomp.omp_outlined
