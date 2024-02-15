BITS 64

section .text
	global ft_strdup

extern ft_strdup

ft_strdup:
	; save register
	push RDI			;
	push RSI			;
	push RCX			;

_ft_strdup_end:
	mov BYTE [RDI], 0x0
	; restore register
	pop RCX
	pop RSI
	pop RDI
	mov RAX, RDI
	ret				; return
