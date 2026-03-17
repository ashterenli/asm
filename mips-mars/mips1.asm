.data

n1: .word  1
n2: .word  2
n3: .word  3
n4: .word  4

.text

la $s1, n1
la $s2, n2
la $s3, n3
la $s4, n4
lw $s1, 0($s1)
lw $s2, 0($s2)
lw $s3, 0($s3)
lw $s4, 0($s4)
add $t0, $s1, $s2
add $t1, $s3, $s4
sub $s0, $t0, $t1


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

add $t0, $s1, $s2
add $t1, $s3, $s4
sub $s0, $t0, $t1

li $v0, 1            # print int
add $a0, $s0, $zero
syscall
