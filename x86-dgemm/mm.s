	.text
	.file	"mm.c"
                                        # Start of file scope inline assembly
.symver __qsort_r_compat, qsort_r@FBSD_1.0

                                        # End of file scope inline assembly
	.globl	mm                              # -- Begin function mm
	.p2align	4, 0x90
	.type	mm,@function
mm:                                     # @mm
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
	movq	%rcx, -80(%rbp)                 # 8-byte Spill
	movq	%rdx, -72(%rbp)                 # 8-byte Spill
	movq	%rsi, -56(%rbp)                 # 8-byte Spill
	movl	%edi, -44(%rbp)                 # 4-byte Spill
	testl	%edi, %edi
	jle	.LBB0_12
# %bb.1:                                # %.preheader26.us.preheader
	movl	-44(%rbp), %eax                 # 4-byte Reload
	movl	%eax, %r8d
	andl	$3, %r8d
	movl	%eax, %r9d
	andl	$2147483644, %r9d               # imm = 0x7FFFFFFC
	movq	-56(%rbp), %rcx                 # 8-byte Reload
	addq	$24, %rcx
	movq	%rcx, -64(%rbp)                 # 8-byte Spill
	leaq	(,%rax,8), %r11
	leaq	(%r11,%r11,2), %rbx
	movq	%rax, %r14
	shlq	$5, %r14
	movq	%rax, %r15
	shlq	$4, %r15
	xorl	%ecx, %ecx
	xorl	%esi, %esi
	jmp	.LBB0_2
	.p2align	4, 0x90
.LBB0_11:                               # %._crit_edge30.split.us.us
                                        #   in Loop: Header=BB0_2 Depth=1
	movq	-88(%rbp), %rsi                 # 8-byte Reload
	incq	%rsi
	movq	-96(%rbp), %rcx                 # 8-byte Reload
	addl	-44(%rbp), %ecx                 # 4-byte Folded Reload
	cmpq	%rax, %rsi
	je	.LBB0_12
.LBB0_2:                                # %.preheader26.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
                                        #       Child Loop BB0_6 Depth 3
                                        #       Child Loop BB0_9 Depth 3
	movq	%rcx, -96(%rbp)                 # 8-byte Spill
	movl	%ecx, %ecx
	movq	-64(%rbp), %rdx                 # 8-byte Reload
	leaq	(%rdx,%rcx,8), %r10
	movq	%rsi, -88(%rbp)                 # 8-byte Spill
	movq	%rsi, %rdx
	imulq	%rax, %rdx
	movq	-80(%rbp), %rsi                 # 8-byte Reload
	leaq	(%rsi,%rdx,8), %rdi
	movq	-56(%rbp), %rdx                 # 8-byte Reload
	leaq	(%rdx,%rcx,8), %rcx
	movq	%rcx, -104(%rbp)                # 8-byte Spill
	movq	-72(%rbp), %rdx                 # 8-byte Reload
	xorl	%r12d, %r12d
	jmp	.LBB0_3
	.p2align	4, 0x90
.LBB0_10:                               # %._crit_edge.us.us
                                        #   in Loop: Header=BB0_3 Depth=2
	vmovsd	%xmm0, (%rdi,%r12,8)
	incq	%r12
	addq	$8, %rdx
	cmpq	%rax, %r12
	je	.LBB0_11
.LBB0_3:                                # %.preheader.us.us
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_6 Depth 3
                                        #       Child Loop BB0_9 Depth 3
	cmpl	$4, -44(%rbp)                   # 4-byte Folded Reload
	jae	.LBB0_5
# %bb.4:                                #   in Loop: Header=BB0_3 Depth=2
	vxorpd	%xmm0, %xmm0, %xmm0
	xorl	%r13d, %r13d
	jmp	.LBB0_7
	.p2align	4, 0x90
.LBB0_5:                                # %.preheader.us.us.new.preheader
                                        #   in Loop: Header=BB0_3 Depth=2
	vxorpd	%xmm0, %xmm0, %xmm0
	movq	%rdx, %rsi
	xorl	%r13d, %r13d
	.p2align	4, 0x90
.LBB0_6:                                # %.preheader.us.us.new
                                        #   Parent Loop BB0_2 Depth=1
                                        #     Parent Loop BB0_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovsd	-24(%r10,%r13,8), %xmm1         # xmm1 = mem[0],zero
	vmulsd	(%rsi), %xmm1, %xmm1
	vmovsd	-16(%r10,%r13,8), %xmm2         # xmm2 = mem[0],zero
	vaddsd	%xmm0, %xmm1, %xmm0
	vmulsd	(%rsi,%rax,8), %xmm2, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovsd	-8(%r10,%r13,8), %xmm1          # xmm1 = mem[0],zero
	vmulsd	(%rsi,%r15), %xmm1, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovsd	(%r10,%r13,8), %xmm1            # xmm1 = mem[0],zero
	vmulsd	(%rsi,%rbx), %xmm1, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	addq	$4, %r13
	addq	%r14, %rsi
	cmpq	%r13, %r9
	jne	.LBB0_6
.LBB0_7:                                # %._crit_edge.us.us.unr-lcssa
                                        #   in Loop: Header=BB0_3 Depth=2
	testq	%r8, %r8
	je	.LBB0_10
# %bb.8:                                # %.epil.preheader.preheader
                                        #   in Loop: Header=BB0_3 Depth=2
	movq	%r11, %rsi
	imulq	%r13, %rsi
	addq	%rdx, %rsi
	movq	-104(%rbp), %rcx                # 8-byte Reload
	leaq	(%rcx,%r13,8), %r13
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB0_9:                                # %.epil.preheader
                                        #   Parent Loop BB0_2 Depth=1
                                        #     Parent Loop BB0_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovsd	(%r13,%rcx,8), %xmm1            # xmm1 = mem[0],zero
	vmulsd	(%rsi), %xmm1, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	incq	%rcx
	addq	%r11, %rsi
	cmpq	%rcx, %r8
	jne	.LBB0_9
	jmp	.LBB0_10
.LBB0_12:                               # %._crit_edge
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	mm, .Lfunc_end0-mm
	.cfi_endproc
                                        # -- End function
	.ident	"FreeBSD clang version 18.1.6 (https://github.com/llvm/llvm-project.git llvmorg-18.1.6-0-g1118c2e05e67)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
