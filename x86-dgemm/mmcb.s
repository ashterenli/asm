	.text
	.file	"mmcb.c"
                                        # Start of file scope inline assembly
.symver __qsort_r_compat, qsort_r@FBSD_1.0

                                        # End of file scope inline assembly
	.globl	mmcb                            # -- Begin function mmcb
	.p2align	4, 0x90
	.type	mmcb,@function
mmcb:                                   # @mmcb
	.cfi_startproc
# %bb.0:
	testl	%edi, %edi
	jle	.LBB0_8
# %bb.1:                                # %.preheader18.us.preheader
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
	subq	$24, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movq	%rdx, %r13
	movq	%rsi, %rbx
	xorl	%r12d, %r12d
	movq	%rcx, -56(%rbp)                 # 8-byte Spill
	movl	%edi, -44(%rbp)                 # 4-byte Spill
	.p2align	4, 0x90
.LBB0_2:                                # %.preheader18.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
                                        #       Child Loop BB0_4 Depth 3
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB0_3:                                # %.preheader.us.us
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_4 Depth 3
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB0_4:                                #   Parent Loop BB0_2 Depth=1
                                        #     Parent Loop BB0_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	%rcx, (%rsp)
	movl	-44(%rbp), %edi                 # 4-byte Reload
	movl	%r12d, %esi
	movl	%r15d, %edx
	movl	%r14d, %ecx
	movq	%rbx, %r8
	movq	%r13, %r9
	callq	block
	movl	-44(%rbp), %edi                 # 4-byte Reload
	movq	-56(%rbp), %rcx                 # 8-byte Reload
	addl	$32, %r14d
	cmpl	%edi, %r14d
	jl	.LBB0_4
# %bb.5:                                # %._crit_edge.us.us
                                        #   in Loop: Header=BB0_3 Depth=2
	addl	$32, %r15d
	cmpl	%edi, %r15d
	jl	.LBB0_3
# %bb.6:                                # %._crit_edge21.split.us.us
                                        #   in Loop: Header=BB0_2 Depth=1
	addl	$32, %r12d
	cmpl	%edi, %r12d
	jl	.LBB0_2
# %bb.7:
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	.cfi_restore %rbx
	.cfi_restore %r12
	.cfi_restore %r13
	.cfi_restore %r14
	.cfi_restore %r15
	.cfi_restore %rbp
.LBB0_8:                                # %._crit_edge
	retq
.Lfunc_end0:
	.size	mmcb, .Lfunc_end0-mmcb
	.cfi_endproc
                                        # -- End function
	.ident	"FreeBSD clang version 18.1.6 (https://github.com/llvm/llvm-project.git llvmorg-18.1.6-0-g1118c2e05e67)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
