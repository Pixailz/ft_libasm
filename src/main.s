BITS 64

%include "libasm.inc"

section .data
	text_variable db ""

section .text
	global _start

_start:
	; jmp _test_hello_world
	jmp _test_ft_strlen

_test_hello_world:
	call hello_world
	call _exit_success

_test_ft_strlen:
	mov rdi, text_variable	; set text addr to RDI
	call ft_strlen			; call ft_strlen
	call _exit_success
