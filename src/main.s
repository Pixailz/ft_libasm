BITS 64

%include "libasm.inc"

section .text
	global _start

_start:
	call hello_world
	call _exit_success
