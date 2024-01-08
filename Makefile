NAME				:= libasm.a
PROG_NAME			:= test
SRC_DIR				:= src
OBJ_DIR				:= obj
INC_DIR				:= inc

LD					:= ld
LDFLAGS				:=

CCASM				:= nasm
CCASMFLAGS			:= -Iinc -f elf64

SRC_ASM				:=	exit.s \
						hello_world.s \
						ft_strlen.s \
						ft_strcmp.s

OBJ_ASM				:= $(addprefix $(OBJ_DIR)/,$(SRC_ASM:%.s=%.o))
SRC_ASM				:= $(addprefix $(SRC_DIR)/,$(SRC_ASM))

all: 				$(NAME)

$(NAME): 			$(OBJ_ASM)
	ar rcs $(NAME) $(OBJ_ASM)

$(OBJ_ASM): 		$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@[ ! -d $(@D) ] && mkdir -p $(@D) || true
	$(CCASM) $(CCASMFLAGS) $< -o $@

clean:
	rm -rf $(OBJ_ASM)

fclean:				clean
	rm -rf $(NAME) $(PROG_NAME)

re: 				fclean all

$(PROG_NAME):		re
	$(CCASM) $(CCASMFLAGS) $(SRC_DIR)/main.s -o $(OBJ_DIR)/main.o
	$(LD) $(LDFLAGS) $(NAME) $(OBJ_DIR)/main.o -o $(PROG_NAME)

run:				$(PROG_NAME)
	./$(PROG_NAME)
