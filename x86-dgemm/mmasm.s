	.text
	.file	"mmasm.c"
                                        # Start of file scope inline assembly
.symver __qsort_r_compat, qsort_r@FBSD_1.0

                                        # End of file scope inline assembly
	.globl	mmasm                           # -- Begin function mmasm
	.p2align	4, 0x90
	.type	mmasm,@function
mmasm:                                  # @mmasm
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
	movq	%rcx, -56(%rbp)                 # 8-byte Spill
	movq	%rsi, -48(%rbp)                 # 8-byte Spill
	testl	%edi, %edi
	jle	.LBB0_11
# %bb.1:                                # %.preheader28.us.preheader
	movq	%rdx, %rcx
	movl	%edi, %eax
	movl	%eax, %r8d
	andl	$2147483646, %r8d               # imm = 0x7FFFFFFE
	leaq	(,%rax,8), %r9
	movq	%rax, %r10
	shlq	$4, %r10
	movq	-48(%rbp), %rdx                 # 8-byte Reload
	leaq	8(%rdx), %r11
	xorl	%esi, %esi
	jmp	.LBB0_2
	.p2align	4, 0x90
.LBB0_10:                               # %._crit_edge32.split.us.us
                                        #   in Loop: Header=BB0_2 Depth=1
	incq	%rsi
	addq	%r9, %r11
	cmpq	%rax, %rsi
	je	.LBB0_11
.LBB0_2:                                # %.preheader28.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
                                        #       Child Loop BB0_6 Depth 3
	movq	%rsi, %rdx
	imulq	%rax, %rdx
	movq	-48(%rbp), %rbx                 # 8-byte Reload
	leaq	(%rbx,%rdx,8), %r14
	movq	-56(%rbp), %rbx                 # 8-byte Reload
	leaq	(%rbx,%rdx,8), %r15
	movq	%rcx, %rdx
	xorl	%r13d, %r13d
	jmp	.LBB0_3
	.p2align	4, 0x90
.LBB0_9:                                # %._crit_edge.us.us
                                        #   in Loop: Header=BB0_3 Depth=2
	vmovapd	%ymm0, (%r15,%r13,8)
	addq	$4, %r13
	addq	$32, %rdx
	cmpq	%rax, %r13
	jae	.LBB0_10
.LBB0_3:                                # %.preheader.us.us
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_6 Depth 3
	vxorpd	%xmm0, %xmm0, %xmm0
	cmpl	$1, %edi
	jne	.LBB0_5
# %bb.4:                                #   in Loop: Header=BB0_3 Depth=2
	xorl	%ebx, %ebx
	jmp	.LBB0_7
	.p2align	4, 0x90
.LBB0_5:                                # %.preheader.us.us.new.preheader
                                        #   in Loop: Header=BB0_3 Depth=2
	movq	%rdx, %r12
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB0_6:                                # %.preheader.us.us.new
                                        #   Parent Loop BB0_2 Depth=1
                                        #     Parent Loop BB0_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vbroadcastsd	-8(%r11,%rbx,8), %ymm1
	vmulpd	(%r12), %ymm1, %ymm1
	vaddpd	%ymm1, %ymm0, %ymm0
	vbroadcastsd	(%r11,%rbx,8), %ymm1
	vmulpd	(%r12,%r9), %ymm1, %ymm1
	vaddpd	%ymm1, %ymm0, %ymm0
	addq	$2, %rbx
	addq	%r10, %r12
	cmpq	%rbx, %r8
	jne	.LBB0_6
.LBB0_7:                                # %._crit_edge.us.us.unr-lcssa
                                        #   in Loop: Header=BB0_3 Depth=2
	testb	$1, %al
	je	.LBB0_9
# %bb.8:                                # %._crit_edge.us.us.epilog-lcssa
                                        #   in Loop: Header=BB0_3 Depth=2
	leaq	(%rcx,%r13,8), %r12
	vbroadcastsd	(%r14,%rbx,8), %ymm1
	imulq	%rax, %rbx
	vmulpd	(%r12,%rbx,8), %ymm1, %ymm1
	vaddpd	%ymm1, %ymm0, %ymm0
	jmp	.LBB0_9
.LBB0_11:                               # %._crit_edge
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
	.size	mmasm, .Lfunc_end0-mmasm
	.cfi_endproc
                                        # -- End function
	.ident	"FreeBSD clang version 18.1.6 (https://github.com/llvm/llvm-project.git llvmorg-18.1.6-0-g1118c2e05e67)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
