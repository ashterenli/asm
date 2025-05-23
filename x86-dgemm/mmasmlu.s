	.text
	.file	"mmasmlu.c"
                                        # Start of file scope inline assembly
.symver __qsort_r_compat, qsort_r@FBSD_1.0

                                        # End of file scope inline assembly
	.globl	mmasmlu                         # -- Begin function mmasmlu
	.p2align	4, 0x90
	.type	mmasmlu,@function
mmasmlu:                                # @mmasmlu
	.cfi_startproc
# %bb.0:
                                        # kill: def $edi killed $edi def $rdi
	testl	%edi, %edi
	jle	.LBB0_8
# %bb.1:                                # %.preheader40.us.preheader
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movl	%edi, %eax
	decl	%edi
	shrl	$4, %edi
	incl	%edi
	addq	$96, %rdx
	leaq	(,%rax,8), %r8
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB0_2:                                # %.preheader40.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
                                        #       Child Loop BB0_4 Depth 3
	movl	%r9d, %r10d
	imull	%eax, %r10d
	leaq	(%rcx,%r10,8), %r10
	movq	%rdx, %r11
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB0_3:                                # %.preheader39.us.us
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_4 Depth 3
	movq	%rbx, %r14
	shlq	$7, %r14
	vxorpd	%xmm0, %xmm0, %xmm0
	movq	%r11, %r15
	vxorpd	%xmm1, %xmm1, %xmm1
	vxorpd	%xmm2, %xmm2, %xmm2
	vxorpd	%xmm3, %xmm3, %xmm3
	xorl	%r12d, %r12d
	.p2align	4, 0x90
.LBB0_4:                                #   Parent Loop BB0_2 Depth=1
                                        #     Parent Loop BB0_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vbroadcastsd	(%rsi,%r12,8), %ymm4
	vmulpd	-96(%r15), %ymm4, %ymm5
	vaddpd	%ymm5, %ymm3, %ymm3
	vmulpd	-64(%r15), %ymm4, %ymm5
	vmulpd	-32(%r15), %ymm4, %ymm6
	vaddpd	%ymm5, %ymm2, %ymm2
	vaddpd	%ymm6, %ymm1, %ymm1
	vmulpd	(%r15), %ymm4, %ymm4
	vaddpd	%ymm4, %ymm0, %ymm0
	incq	%r12
	addq	%r8, %r15
	cmpq	%r12, %rax
	jne	.LBB0_4
# %bb.5:                                # %..preheader_crit_edge.us.us
                                        #   in Loop: Header=BB0_3 Depth=2
	vmovapd	%ymm3, (%r10,%r14)
	vmovapd	%ymm2, 32(%r10,%r14)
	vmovapd	%ymm1, 64(%r10,%r14)
	vmovapd	%ymm0, 96(%r10,%r14)
	incq	%rbx
	subq	$-128, %r11
	cmpq	%rdi, %rbx
	jne	.LBB0_3
# %bb.6:                                # %._crit_edge.split.us.us
                                        #   in Loop: Header=BB0_2 Depth=1
	incq	%r9
	addq	%r8, %rsi
	cmpq	%rax, %r9
	jne	.LBB0_2
# %bb.7:
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	.cfi_restore %rbx
	.cfi_restore %r12
	.cfi_restore %r14
	.cfi_restore %r15
	.cfi_restore %rbp
.LBB0_8:                                # %._crit_edge
	vzeroupper
	retq
.Lfunc_end0:
	.size	mmasmlu, .Lfunc_end0-mmasmlu
	.cfi_endproc
                                        # -- End function
	.ident	"FreeBSD clang version 18.1.6 (https://github.com/llvm/llvm-project.git llvmorg-18.1.6-0-g1118c2e05e67)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
