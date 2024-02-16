%ifndef LIBASM_INC
%define LIBASM_INC

; CORRECTLY INCLUDING THIS MF** OF __errno_location
extern __errno_location
global __errno_location

; 0x00
%include "src/exit.s"
%include "src/ft_strlen.s"
%include "src/ft_write.s"
%include "src/ft_read.s"

; 0x01
%include "src/ft_strcmp.s"
%include "src/ft_strcpy.s"
%include "src/ft_strdup.s"

%endif ; LIBASM_INC
