BITS 64

section .data

section .text
	global ft_strdup
	extern ft_strlen
	extern malloc

ft_strdup:
	; save register
	push RDI			;
	call ft_strlen		; get length to dup
	add RAX, 0x1		; NULL byte
	call malloc wrt ..plt

	repne movsb

_ft_strdup_end:
	; restore register
	pop RDI
	mov RAX, RDI
	ret				; return
