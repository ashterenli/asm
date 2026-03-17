# strcpy example
# - 2 static arrays of size 4 byte are declared - str1 and str2
# - str1 is set to null terminated string "abc"
# - str1 is printed using "print" function
# - str2 is copied from str1 using "strcpy" function
# - str2 is printed using "print" function
.data
	str1:	.space	4	# 4 bytes, for 4 chars - 3-char string + null
	str2:	.space	4	# the same
.text
main:	la	$t0, str1	#  load base address of array into register $t0
	li	$t1, 'a'	
	sb	$t1, ($t0)	# store to str element 0
	li	$t1, 'b'	#
	sb	$t1, 1($t0)	# store to str element 1
	li	$t1, 'c'	#
	sb	$t1, 2($t0)	# store to str element 2
	li	$t1, '\0'	#
	sb	$t1, 3($t0)	# store to str element 3

	la	$a0, str1	# prepare to call print - set $a0 to start of str1
	jal	print		# jump to print string

	la	$a1, str2	# prepare to call strcpy - set $a1 to start of str2
	jal	strcpy		# jump to str copy
	la	$a0, str2	# prepare to call print on str2
	jal	print
	
	li	$v0, 10         	  # exit
	syscall
	
# ===== program end

# print string -- $a0 is the addr of the start
print:	addi	$sp, $sp, -4		# get a word on stack
	sw	$a0, 0($sp)		# push $a0 to stack

	add	$t0, $a0, $zero		# $t0 will be incremented
pstart:	lb	$a0, 0($t0)		# get the char to print
	li	$v0, 11			# print char
	syscall
	
	beq	$a0, $zero, pend	# exit loop if null char was printed
	addi	$t0, $t0, 1		# increment str pointer by 1 byte
	j	pstart			# continue printing
	
pend:	lw	$a0, 0($sp)		# restore $a0
	addi	$sp, $sp, 4		# restore $sp
	jr	$ra
	
# strcpy
# $a0 - from addr
# $a1 - to addr
strcpy:	add	$t0, $a0, $zero		# $t0 points to current element of str1
	add	$t1, $a1, $zero		# $t1 points to current element of str2
cpystart:
	lb	$t3, 0($t0)		# load byte from str1
	sb	$t3, 0($t1)		# save byte to str2
	beq	$t3, $zero, cpyend	# exit loop if null char was copied
	addi	$t0, $t0, 1		# increment the pointers
	addi	$t1, $t1, 1
	j	cpystart
cpyend:
	jr	$ra
