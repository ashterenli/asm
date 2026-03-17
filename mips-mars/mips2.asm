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

add $t0, $s0, $s1
add $t1, $s2, $s3
sub $s0, $t0, $t1

li $v0, 1            # print int
add $a0, $s0, $zero
syscall
