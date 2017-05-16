#CC = arm-linux-gcc
CC := gcc
PWD		:= $(shell pwd)
LIB_DIR := $(IMAGE_SRC_DIR)/lib
CFLAG += -Os -I$(AUTOCONF_DIR) -I$(LIB_DIR)

TARGET := md5_encrypt

OBJ := md5_encrypt.o
#OBJ += snx_encrypt_decrypt.o

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAG) -o $@ $(OBJ)

md5_encrypt.o: md5_encrypt.c
	$(CC) -c $(CFLAG)  $<

clean:
	rm -rf $(OBJ) ./$(TARGET)
