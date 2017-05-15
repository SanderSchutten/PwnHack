PWD		:= $(shell pwd)
#CC = arm-linux-gcc
CC := gcc
LIB_DIR := $(IMAGE_SRC_DIR)/lib
CFLAG += -Os -I$(AUTOCONF_DIR) -I$(LIB_DIR)

TARGET := crc_calculation

OBJ := crc_calculation.o

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAG) -o $@ $(OBJ)

%.o: %.c
	$(CC) -c $(CFLAG)  $<

clean:
	rm -rf $(OBJ) ./$(TARGET)
