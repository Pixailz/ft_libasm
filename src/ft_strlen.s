BITS 64

section .text
	global ft_strlen

ft_strlen:
	push			RDI					; save RDI
	push			RCX					; save RCX
	xor				RCX, RCX			; set RCX = 0
	cmp 			RDI, 0x0			; check if RDI == null
	je				_ft_strlen_end		; jump if equal
	pxor			XMM0, XMM0			; set XMM0 = 0

_ft_strlen_loop:
	movdqu			XMM1, [RDI + RCX]	; load *(RDI + RCX) into XMM1
	vpcmpeqb		XMM0, XMM1			; search for XMM0 in XMM1
	vpmovmskb		RAX, XMM0			; convert XMM0 into a mask
	test			RAX, RAX			; test RAX
	jnz				_ft_strlen_zfound	; jump if RAX != 0
	add				RCX, 0x10			; add 0x10 to RCX
	jmp				_ft_strlen_loop		; loop until zero is found

_ft_strlen_zfound:
	bsf				RDI, RAX			; scan for first bit
	add				RCX, RDI			; add index of first bit to RCX

_ft_strlen_end:
	mov				RAX, RCX			; copy RCX into RAX
	pop				RCX					; restore RCX
	pop				RDI					; restore RDI
	ret

