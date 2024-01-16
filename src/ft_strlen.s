BITS 64

section .text
	global ft_strlen

ft_strlen:
	; save register
	push RDI				; const char *s
	push RCX				; int i
	xor RCX, RCX			; RCX = 0
	cmp BYTE [RDI], 0x0		; if RDI == NULL
	je _ft_strlen_end		; JMP IF EQUAL
	not RCX					; RCX = -1

_ft_strlen_loop:
	cld				; clear direction flag
	xor AL, AL		;
	repnz scasb		; repeat scasb until *RDI != al
	not RCX			; flip RCX back
	sub RCX, 0x1	; RCX -= 1

_ft_strlen_end:
	mov RAX, RCX	; load RCX into RAX
	; restore register
	pop RCX			;
	pop RDI			;
	ret				; ret
