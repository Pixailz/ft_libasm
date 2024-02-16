BITS 64

%include "libasm.inc"

section .data
	t1 DB "Test", 0
	t2 DB "test", 0
	src DB "1234", 0
	hello_world DB "Hello world", 0x0A, 0
	hello_world_len EQU $ - hello_world

section .bss
	dst_strcpy RESB 5
	dst_read RESB 5

section .text
	global _start

_start:
	; jmp _test_ft_strlen
	; jmp _test_ft_strcmp
	; jmp _test_ft_strcpy
	; jmp _test_ft_write
	; jmp _test_ft_read
	jmp _test_ft_strdup

_test_ft_strlen:
	mov RDI, t1			; set text addr to RDI
	call ft_strlen		; call ft_strlen
	jmp _end			; goto end

_test_ft_strcmp:
	mov RDI, t1		; set arg1
	mov RSI, t2		; set arg2
	call ft_strcmp	; call ft_strcmp
	jmp _end		; goto end

_test_ft_strcpy:
	mov RDI, src		; set arg1
	mov RSI, dst_strcpy	; set arg2
	call ft_strcpy		; call ft_strcpy
	jmp _end			; goto end

_test_ft_write:
	mov RDI, 0x1				; set arg1
	mov RSI, hello_world		; set arg2
	mov RDX, hello_world_len	; set arg3
	call ft_write				; call ft_write
	jmp _end					; goto end

_test_ft_read:
	mov RDI, 0x0		; set arg1
	mov RSI, dst_read	; set arg2
	mov RDX, 0x5		; set arg3
	call ft_read		; call ft_read
	mov RDI, 0x1
	call ft_write
	jmp _end			; goto end

_test_ft_strdup:
	mov RDI, t1			; set arg1
	call ft_strdup
	jmp _end

_end:
	call _exit_success
