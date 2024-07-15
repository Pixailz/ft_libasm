BITS 64

section .text
	global ft_strdup
	extern ft_strlen
	extern malloc

;rdi, rsi, rdx, rcx
ft_strdup:
	; save register
	push RDI				;
	push RSI				;
	push RDX				;
	push RCX				;

	cmp RDI, 0x0			; error if RDI == 0
	je _ft_strdup_error		;

	call ft_strlen			; get length of RDI
	push RAX				; save length without null byte
	add RAX, 0x1			; NULL byte
	push RDI				; save RDI from malloc
	mov RDI, RAX			; set arg for malloc
	call malloc wrt ..plt	; call malloc

	pop RSI					; get str
	pop RCX					; get length without null byte
	cmp RAX, 0x0			; check if malloc fail
	je _ft_strdup_error		;

	push RAX				; save malloc head
	mov RDI, RAX
	cld						; clear direction flags
	repz movsb				; do *RSI++ == *RDI++ until RCX != 0

	mov BYTE [RDI], 0x0		; add null byte
	pop RAX					; get back head of malloc

_ft_strdup_end:
	; restore register
	pop RCX
	pop RDX
	pop RSI
	pop RDI
	ret				; return

_ft_strdup_error:
	mov RAX, 0x0
	jmp _ft_strdup_end
