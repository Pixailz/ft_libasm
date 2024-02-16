BITS 64

section .text
	global ft_write

extern __errno_location

ft_write:
	; save register
	push RDI			; int fd
	push RSI			; const void buf
	push RDX			; size_t count

_ft_write:
	mov RAX, 0x1		; write syscall
	syscall				; syscall
	cmp RAX, 0x0		; check if error while syscall
	jl _ft_write_error	; if so

_ft_write_end:
	; restore register
	pop RDX			;
	pop RSI			;
	pop RDI			;
	ret

_ft_write_error:
	neg RAX								; reverse syscal return, to get errno
	mov RCX, RAX						; save RAX
	call __errno_location WRT ..plt		; get errno location into RAX
	mov [RAX], RCX;						; set errno according to saved RAX
	mov RAX, -1							; set retv to -1
	jmp _ft_write_end
