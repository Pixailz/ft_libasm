BITS 64

_exit_success:
	mov rax, 0x3c		; exit syscall
	xor rdi, rdi		; exit value
	syscall				; kernel interrupt

_exit_failed:
	mov rax, 0x3c		; exit syscall
	mov rdi, 1			; exit value
	syscall				; kernel interrupt
