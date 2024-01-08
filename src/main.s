BITS 64

%include "libasm.inc"

section .data
	t1 db "Test", 0
	t2 db "test", 0

section .text
	global _start

_start:
	; jmp _test_hello_world
	; jmp _test_ft_strlen
	jmp _test_ft_strcmp

_test_hello_world:
	call hello_world
	call _exit_success

_test_ft_strlen:
	mov rdi, t1			; set text addr to RDI
	call ft_strlen		; call ft_strlen
	call _exit_success

_test_ft_strcmp:
	mov rdi, t1		; set arg1
	mov rsi, t2		; set arg2
	call ft_strcmp	; call ft_strlen
	call _exit_success
