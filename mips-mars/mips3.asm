.data

.text

li $v0, 5            # read in 
syscall
add $s0, $v0, $zero  # assign to $s0
li $v0, 5            # read in
syscall
add $s1, $v0, $zero  # assign to $s1
li $v0, 5            # read in
syscall
add $s2, $v0, $zero  # assign to $s2
li $v0, 5            # read in
syscall
add $s3, $v0, $zero  # assign to $s3

add $a0, $s0, $zero # prepare arg1
add $a1, $s1, $zero # prepare arg2
jal add2
add $t0, $v0, $zero # save result

add $a0, $s2, $zero # prepare arg1
add $a1, $s3, $zero # prepare arg2
jal add2
add $t1, $v0, $zero # save result

sub $s0, $t0, $t1

li $v0, 1            # print int
add $a0, $s0, $zero
syscall

li $v0, 10           # exit
syscall


add2:
#	sw $ra, 0($sp)
	addi $sp, $sp, -12   # reserve 3 words on stack
	sw $ra, 0($sp)       # push $ra
	sw $a0, 4($sp)       # push $a0
	sw $a1, 8($sp)       # push $a1
	
	# pass $a0 as is
	jal scale1
	add $t0, $v0, $zero  # save result

	add $a0, $a1, $zero  # prepare arg1 for scale1
	jal scale1
	add $t1, $v0, $zero  # save result
	
	add $v0, $t0, $t1    # copy to $v0
	
	lw $a1, 8($sp)       # pop $a1 from stack
	lw $a0, 4($sp)       # pop $a0 from stack
	lw $ra, 0($sp)       # pop $ra
	addi $sp, $sp, 12     # reset $sp back

	jr $ra

scale1:
	addi $sp, $sp, -4   # reserve space for 3 words on stack
	sw $ra, 0($sp)       # push $ra
	mul $v0, $a0, 2
	lw $ra, 0($sp)
	addi $sp, $sp, 4    # restore $sp
	
	jr $ra
