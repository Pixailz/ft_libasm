BITS 64

%include "libasm.inc"

section .data
	t1 DB "Test", 0
	t2 DB "test", 0
	src DB "1234", 0

section .bss
	dst RESB 5

section .text
	global _start

_start:
	; jmp _test_ft_strlen
	; jmp _test_ft_strcmp
	jmp _test_ft_strcpy

_test_ft_strlen:
	mov RDI, t1			; set text addr to RDI
	call ft_strlen		; call ft_strlen
	jmp _start_end	; goto end

_test_ft_strcmp:
	mov RDI, t1		; set arg1
	mov RSI, t2		; set arg2
	call ft_strcmp	; call ft_strlen
	jmp _start_end	; goto end

_test_ft_strcpy:
	mov RDI, src	; set arg1
	mov RSI, dst	; set arg2
	call ft_strcpy	; call ft_strlen
	jmp _start_end	; goto end

_start_end:
	call _exit_success
