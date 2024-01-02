BITS 64

section .text
	global ft_strlen

ft_strlen:
	push rdi			; save register
	push rcx			;
	xor rcx, rcx		; set rcx to 0 then to -1
	not rcx				;
	repnz scasb			; repeat scasb until *rcx != 0
	not rcx				; flip rcx back
	lea rax, [rcx - 1]	; load [rcx - 1] into rax
	pop rcx				; restore register
	pop rdi				;
	ret					; ret
