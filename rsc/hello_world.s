BITS 64

section .data
	test_txt db "Hello World", 0x0a		; define a string
	test_txt_len equ $ - test_txt		; get the len of the string

section .text
	global hello_world

hello_world:
	mov rax, 0x01						; write syscall
	mov rdi, 0x01						; int fd
	mov rsi, $test_txt					; const char *buff
	mov rdx, $test_txt_len				; size_t len
	syscall
	ret
