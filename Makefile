CC = 			arm-none-eabi-gcc

ARCH_FLAGS =		-mthumb-interwork -mthumb
CC_FLAGS = 		$(ARCH_FLAGS) -O2 -Wall -fno-strict-aliasing
LD_FLAGS =		$(ARCH_FLAGS) -specs=gba.specs

OBJ_COPY =		arm-none-eabi-objcopy
OBJ_COPY_FLAGS = 	-v -O binary

FIX =			gbafix

SRC_PATH := 	src
OBJ_PATH := 	obj
BIN_PATH := 	bin

SRC := $(foreach x, $(SRC_PATH), $(wildcard $(addprefix $(x)/*,.c*)))
OBJ := $(addprefix $(OBJ_PATH)/, $(addsuffix .o, $(notdir $(basename $(SRC)))))

TARGET_ELF = 	$(BIN_PATH)/game.elf
TARGET_GBA =	$(BIN_PATH)/game.gba


default: makedir all


# Peut-être inutile mais permet d'éviter le blocage de la compilation si le `.h` n'existe pas
$(SRC_PATH)/%.h: $(SRC_PATH)/%.c
	@touch $(SRC_PATH)/$*.h


# Cross-compile les fichiers pour GBA
$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c $(SRC_PATH)/%.h
	@echo -e "\n\033[1m=>	Compiling files\033[0m"
	$(CC) $(CC_FLAGS) -c $< -o $@


# Effectue le linking des fichiers
$(TARGET_ELF):$(OBJ)
	@echo -e "\n\033[1m=>	Linking files\033[0m"
	$(CC) $^ $(LD_FLAGS) -o $@


# Finalise la ROM
$(TARGET_GBA):$(TARGET_ELF)
	@echo -e "\n\033[1m=>	Stripping file of unnecessary informations\033[0m"
	$(OBJ_COPY) $(OBJ_COPY_FLAGS) $< $@
	@echo -e "\n\033[1m=>	Fixing ROM\033[0m"
	$(FIX) $@
	@echo -e "\n\033[1m=>	Done\033[0m"



.PHONY: all
all: $(TARGET_GBA)

.PHONY: makedir
makedir:
	@mkdir -p $(BIN_PATH) $(OBJ_PATH)

.PHONY: clean
clean:
	@rm -fv $(OBJ) $(TARGET_ELF) $(TARGET_GBA)
