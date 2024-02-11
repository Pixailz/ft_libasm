NAME				:= libasm.a
PROG_NAME_C			:= test_c
PROG_NAME_ASM		:= test_asm
SRC_DIR				:= src
OBJ_DIR				:= obj
INC_DIR				:= inc

LD					:= ld
LDFLAGS				:= -z noexecstack

ASM					:= nasm
# -Wextra not available for nasm :'(
ASMFLAGS			:= -Iinc -f elf64 -Wall

CC					:= gcc
CCFLAGS				:= -z noexecstack -Iinc -Wall -Wextra

ifeq ($(DEBUG),1)
ASMFLAGS			+= -ggdb -F dwarf
CCFLAGS				+= -ggdb
else
ASMFLAGS			+= -Werror
CCFLAGS				+= -Werror
endif

SRC_ASM				:=	exit.s \
						ft_strlen.s \
						ft_strcmp.s \
						ft_strcpy.s \
						ft_write.s

OBJ_ASM				:= $(addprefix $(OBJ_DIR)/,$(SRC_ASM:%.s=%.o))
SRC_ASM				:= $(addprefix $(SRC_DIR)/,$(SRC_ASM))

all: 				$(NAME)

$(NAME): 			$(OBJ_ASM)
	ar rcs $(NAME) $(OBJ_ASM)

$(OBJ_ASM): 		$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@[ ! -d $(@D) ] && mkdir -p $(@D) || true
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -rf $(OBJ_ASM)

fclean:				clean
	rm -rf $(NAME) $(PROG_NAME)

re: 				fclean all

$(PROG_NAME_ASM):		re
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/main.s -o $(OBJ_DIR)/main.o
	$(CC) $(CCFLAGS) $(NAME) $(OBJ_DIR)/main.o -o $(PROG_NAME_ASM) 2>/dev/null

run_asm:				$(PROG_NAME_ASM)
	./$(PROG_NAME_ASM)

$(PROG_NAME_C):		re
	$(CC) $(CCFLAGS) $(SRC_DIR)/main.c $(NAME) -o $(PROG_NAME_C)

run_c:				$(PROG_NAME_C)
	./$(PROG_NAME_C)
