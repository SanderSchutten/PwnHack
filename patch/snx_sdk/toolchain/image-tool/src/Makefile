#CC = arm-linux-gcc
CC := gcc
PWD		:= $(shell pwd)
MAKE    ?= make

SRC_TOOLS := tools

.PHONY: $(SRC_TOOLS) clean
$(SRC_TOOLS): 
	$(MAKE) -C $(PWD)/tools

clean:
	$(MAKE) -C $(PWD)/tools clean
	
