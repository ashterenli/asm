	.text
	.file	"mm2d.c"
                                        # Start of file scope inline assembly
.symver __qsort_r_compat, qsort_r@FBSD_1.0

                                        # End of file scope inline assembly
	.globl	mm2d                            # -- Begin function mm2d
	.p2align	4, 0x90
	.type	mm2d,@function
mm2d:                                   # @mm2d
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_1:                                # %.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_2 Depth 2
                                        #       Child Loop BB0_3 Depth 3
	movq	(%rdi,%rax,8), %rcx
	movq	(%rsi,%rax,8), %r8
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB0_2:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_3 Depth 3
	movq	$0, (%rcx,%r9,8)
	vxorpd	%xmm0, %xmm0, %xmm0
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
                                        #     Parent Loop BB0_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovsd	(%r8,%r10,8), %xmm1             # xmm1 = mem[0],zero
	movq	(%rdx,%r10,8), %r11
	vmulsd	(%r11,%r9,8), %xmm1, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, (%rcx,%r9,8)
	vmovsd	8(%r8,%r10,8), %xmm1            # xmm1 = mem[0],zero
	movq	8(%rdx,%r10,8), %r11
	vmulsd	(%r11,%r9,8), %xmm1, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, (%rcx,%r9,8)
	addq	$2, %r10
	cmpq	$1024, %r10                     # imm = 0x400
	jne	.LBB0_3
# %bb.4:                                #   in Loop: Header=BB0_2 Depth=2
	incq	%r9
	cmpq	$1024, %r9                      # imm = 0x400
	jne	.LBB0_2
# %bb.5:                                #   in Loop: Header=BB0_1 Depth=1
	incq	%rax
	cmpq	$1024, %rax                     # imm = 0x400
	jne	.LBB0_1
# %bb.6:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	mm2d, .Lfunc_end0-mm2d
	.cfi_endproc
                                        # -- End function
	.ident	"FreeBSD clang version 18.1.6 (https://github.com/llvm/llvm-project.git llvmorg-18.1.6-0-g1118c2e05e67)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
