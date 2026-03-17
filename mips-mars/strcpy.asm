	.data
string1:	.asciiz	"mumu\n"

	.text
main:	li	$v0, 4		# print string
	la	$a0, string1
	syscall

