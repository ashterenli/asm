	.text
	.file	"mmasmu2.c"
                                        # Start of file scope inline assembly
.symver __qsort_r_compat, qsort_r@FBSD_1.0

                                        # End of file scope inline assembly
	.globl	mmasmu2                         # -- Begin function mmasmu2
	.p2align	4, 0x90
	.type	mmasmu2,@function
mmasmu2:                                # @mmasmu2
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	addq	$8192, %rsi                     # imm = 0x2000
	addq	$8, %rdi
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_1:                                # %.preheader21
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_2 Depth 2
                                        #       Child Loop BB0_3 Depth 3
	movq	%rax, %rcx
	shlq	$13, %rcx
	addq	%rdx, %rcx
	movq	%rsi, %r8
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB0_2:                                # %.preheader
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_3 Depth 3
	vxorpd	%xmm0, %xmm0, %xmm0
	movq	%r8, %r10
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
                                        #     Parent Loop BB0_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vbroadcastsd	-8(%rdi,%r11,8), %ymm1
	vmulpd	-8192(%r10), %ymm1, %ymm1
	vaddpd	%ymm1, %ymm0, %ymm0
	vbroadcastsd	(%rdi,%r11,8), %ymm1
	vmulpd	(%r10), %ymm1, %ymm1
	vaddpd	%ymm1, %ymm0, %ymm0
	addq	$2, %r11
	addq	$16384, %r10                    # imm = 0x4000
	cmpq	$1024, %r11                     # imm = 0x400
	jne	.LBB0_3
# %bb.4:                                #   in Loop: Header=BB0_2 Depth=2
	vmovupd	%ymm0, (%rcx,%r9,8)
	leaq	4(%r9), %r10
	addq	$32, %r8
	cmpq	$1020, %r9                      # imm = 0x3FC
	movq	%r10, %r9
	jb	.LBB0_2
# %bb.5:                                #   in Loop: Header=BB0_1 Depth=1
	incq	%rax
	addq	$8192, %rdi                     # imm = 0x2000
	cmpq	$1024, %rax                     # imm = 0x400
	jne	.LBB0_1
# %bb.6:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	vzeroupper
	retq
.Lfunc_end0:
	.size	mmasmu2, .Lfunc_end0-mmasmu2
	.cfi_endproc
                                        # -- End function
	.ident	"FreeBSD clang version 18.1.6 (https://github.com/llvm/llvm-project.git llvmorg-18.1.6-0-g1118c2e05e67)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
