BITS 64

section .text
	global ft_strcmp

extern ft_strlen

ft_strcmp:
	; save register
	push RDI			; char *s1
	push RSI			; char *s2
	push RCX			; int i
	call ft_strlen		; get s1 len
	mov RCX, RAX		; move RAX into RCX
	xchg RDI, RSI		; exchange RDI and RSI
	call ft_strlen		; get s1 len
	cmp RCX, RAX		; cmp RCX to RAX
	xchg RDI, RSI		; get RDI and RSI back
	jg _ft_strcmp_loop	; JMP IF GREATER
	mov RCX, RAX		; move RAX into RCX

_ft_strcmp_loop:
	cld				; clear direction flag
	repz cmpsb		; repeat until *rdi != al
	sub RDI, 0x1	; RDI - 1
	sub RSI, 0x1	; RSI - 1

_ft_strcmp_end:
	movzx RAX, BYTE [RDI]
	movzx RSI, BYTE [RSI]
	sub RAX, RSI
	; restore register
	pop RCX
	pop RSI
	pop RDI
	ret				; ret
