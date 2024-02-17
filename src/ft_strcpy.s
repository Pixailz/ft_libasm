BITS 64

section .text
	global ft_strcpy

extern ft_strlen

ft_strcpy:
	; save register
	push RDI			; char *dst
	push RSI			; char *src
	push RCX			; int i
	xchg RDI, RSI		; get length of RSI
	call ft_strlen		;
	xchg RDI, RSI		;
	mov RCX, RAX		; move RAX into RCX

_ft_strcpy_loop:
	cld				; clear direction flag
	repz movsb		; repeat while RCX > 0

_ft_strcpy_end:
	mov BYTE [RDI], 0x0
	; restore register
	pop RCX
	pop RSI
	pop RDI
	mov RAX, RDI
	ret				; return
