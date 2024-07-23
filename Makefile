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
CCFLAGS				:= -z noexecstack -Iinc -Wall -Wextra -fPIC

ifeq ($(DEBUG),1)
ASMFLAGS			+= -ggdb -F dwarf
CCFLAGS				+= -ggdb
else
ASMFLAGS			+= -Werror
CCFLAGS				+= -Werror
endif

SRC_ASM				:=	exit.s \
						ft_strlen.avx.s \
						ft_strcmp.s \
						ft_strcpy.s \
						ft_write.s \
						ft_read.s \
						ft_strdup.s

OBJ_ASM				:= $(addprefix $(OBJ_DIR)/,$(SRC_ASM:%.s=%.o))
SRC_ASM				:= $(addprefix $(SRC_DIR)/,$(SRC_ASM))

TESTER_DIR			:= libasm_tester
TESTER_CMD			:= run
TESTER_GIT			:= https://github.com/Pixailz/libasm_tester

MAKECMD				:= make -s
INFO				= @/usr/bin/echo -e [\\x1b[32m+\\x1b[0m] $(1)

# USUAL RULES
all: 				print_obj $(NAME)

$(NAME): 			$(OBJ_ASM)
	$(call INFO,Creating libasm archive)
	ar rcs $(NAME) $(OBJ_ASM)

print_obj:
	$(call INFO,Compiling object)

$(OBJ_ASM): 		$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@[ ! -d $(@D) ] && mkdir -p $(@D) || true
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	$(call INFO,Cleaning libasm)
	rm -rf $(OBJ_ASM)

fclean:				clean
	$(call INFO,Full cleaning libasm)
	rm -rf $(NAME) $(PROG_NAME)

re: 				fclean all

# RUNNING PROGRAM
$(PROG_NAME_ASM):		re
	$(call INFO,Compiling ASM program)
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/main.s -o $(OBJ_DIR)/main.o
	$(CC) $(CCFLAGS) -nostartfiles $(NAME) -lc $(OBJ_DIR)/main.o -o $(PROG_NAME_ASM)

run_asm:				$(PROG_NAME_ASM)
	$(call INFO,Running ASM program)
	./$(PROG_NAME_ASM)

$(PROG_NAME_C):		re
	$(call INFO,Compiling C program)
	$(CC) $(CCFLAGS) $(SRC_DIR)/main.c $(NAME) -o $(PROG_NAME_C)

run_c:				$(PROG_NAME_C)
	$(call INFO,Running C program)
	./$(PROG_NAME_C)

run_c_pre:			$(PROG_NAME_C)
	$(call INFO,Preprocessing file $(PROG_NAME_C).d)
	gcc -E $(CCFLAGS) $(SRC_DIR)/main.c $(NAME) -o $(PROG_NAME_C).d

# TESTER
$(TESTER_DIR):
	git clone $(TESTER_GIT)

test:				$(TESTER_DIR)
	make -C $(TESTER_DIR)
	$(MAKECMD) -C $(TESTER_DIR) $(TESTER_CMD) ; \
	cat $(TESTER_DIR)/exec.log
