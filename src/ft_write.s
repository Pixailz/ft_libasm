BITS 64

section .text
	global ft_write

ft_write:
	; save register
	push RDI			; int fd
	push RSI			; const void buf
	push RDX			; size_t count

_ft_write:
	mov RAX, 0x01		; write syscall
	syscall
	jc _ft_write_error

_ft_write_end:
	; restore register
	pop RDX			;
	pop RSI			;
	pop RDI			;
	ret

_ft_write_error:
	call	errno_location
	mov RAX, [RAX]	;
	jmp _ft_write_end
