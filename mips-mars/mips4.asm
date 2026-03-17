	addi $t0,$zero,-1
	addi $t1,$zero,3

	sltu $s0,$t0,$t1
	beq $s0,$zero,IndexOutOfBounds
	j Exit

IndexOutOfBounds:
	li $v0, 1
	add $a0, $t0, $zero
	syscall

Exit: