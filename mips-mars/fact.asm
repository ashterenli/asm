.data

.text
	li     $v0, 5            # read in value of n 
	syscall
	add    $a0, $v0, $zero   # assign to $a0
	jal    fact

	add    $a0, $v0, $zero   # save v0 into a0
	li     $v0, 1            # print int
	syscall

	li     $v0, 10           # exit
	syscall
	
fact:
	li     $v0, 1            # print int
	syscall

	addi   $sp, $sp, -8      # get space for 2 words
	sw     $ra, 4($sp)       # save return addr
	sw     $a0, 0($sp)       # save the input arg
	
	slti   $t0, $a0, 1       # check for base case
	beq    $t0, $zero, L1    # jump to L1 if n >= 1
	
	addi   $v0, $zero, 1     # return 1
	addi   $sp, $sp, 8       # restore sp. ra or a0 are not changed, no need to load
	jr     $ra
	
L1:
	addi   $a0, $a0, -1
	jal    fact
	
	lw     $a0, 0($sp)
	lw     $ra, 4($sp)
	addi   $sp, $sp, 8
	
	mul    $v0, $a0, $v0
	
	jr     $ra
	