BITS 64

section .text
	global ft_read

extern __errno_location

ft_read:
	; save register
	push RDI			; int fd
	push RSI			; char *buf
	push RDX			; size_t count

_ft_read:
	mov RAX, 0x0		; read syscall
	syscall				; syscall
	cmp RAX, 0x0		; check if error while syscall
	jl _ft_read_error	; if so

_ft_read_end:
	; restore register
	pop RDX			;
	pop RSI			;
	pop RDI			;
	ret

_ft_read_error:
	neg RAX								; reverse syscal return, to get errno
	mov RCX, RAX						; save RAX
	call __errno_location WRT ..plt		; get errno location into RAX
	mov [RAX], RCX;						; set errno according to saved RAX
	mov RAX, -1							; set retv to -1
	jmp _ft_read_end
