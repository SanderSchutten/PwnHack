#CC = arm-linux-gcc
CC := gcc
PWD		:= $(shell pwd)
CFLAG += -Os -I$(AUTOCONF_DIR)

OBJ	:= crc.o
OBJ += snx_encrypt_decrypt.o

all: $(OBJ)

snx_encrypt_decrypt.o: snx_md5/snx_encrypt_decrypt.c
	$(CC) -c $(CFLAG)  $<
crc.o: crc/crc.c
	$(CC) -c $(CFLAG)  $<


clean:
	-rm -rf $(OBJ)
	
