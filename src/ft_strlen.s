BITS 64

section .text
	global ft_strlen

ft_strlen:
	push rdi			; save register (const char *s) rdi
	push rcx			; (int i) rcx
	xor rcx, rcx		; set rcx to 0
	cmp byte [rdi], 0x0	; if rdi == NULL
	je _ft_strlen_end	; JMP IF EQUAL
	not rcx				; flip all bit to have -1

_ft_strlen_loop:
	repnz scasb		; repeat scasb until *rcx != 0
	not rcx			; flip rcx back
	sub rcx, 0x1	; rcx - 1

_ft_strlen_end:
	mov rax, rcx	; load [rcx - 1] into rax
	pop rcx			; restore register
	pop rdi			;
	ret				; ret
