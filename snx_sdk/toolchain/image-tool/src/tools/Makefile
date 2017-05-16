#CC = arm-linux-gcc
CC := gcc
PWD		:= $(shell pwd)
MAKE    ?= make

MD5_TARGET := md5_encrypt
CRC_CALCULATION := crc_calculation
IMAGE_TOOL := image_tool
PHY_SF := phy_sf

.PHONY: $(MD5_TARGET) $(IMAGE_TOOL) $(PHY_SF) $(CRC_CALCULATION) clean
all: $(MD5_TARGET) $(IMAGE_TOOL) $(PHY_SF) $(CRC_CALCULATION)
$(MD5_TARGET):
	$(MAKE) -C $(PWD)/md5_encrypt/
	if [ -e $(PWD)/md5_encrypt/$(MD5_TARGET) ]; then \
		mv $(PWD)/md5_encrypt/$(MD5_TARGET) $(TOOL_DIR)/$(MD5_TARGET); \
    else \
            echo "No md5_encrypt is generated."; \
	exit 1; \
	fi
$(CRC_CALCULATION):
	$(MAKE) -C $(PWD)/crc_calculation/
	if [ -e $(PWD)/crc_calculation/$(CRC_CALCULATION) ]; then \
		mv $(PWD)/crc_calculation/$(CRC_CALCULATION) $(TOOL_DIR)/$(CRC_CALCULATION); \
    else \
            echo "No md5_encrypt is generated."; \
	exit 1; \
	fi
$(IMAGE_TOOL):
	$(MAKE) -C $(PWD)/create_image/
	if [ -e $(PWD)/create_image/$(IMAGE_TOOL) ]; then \
		mv $(PWD)/create_image/$(IMAGE_TOOL) $(TOOL_DIR)/$(IMAGE_TOOL); \
    else \
            echo "No image_tool is generated."; \
	exit 1; \
	fi
$(PHY_SF):
	$(MAKE) -C $(PWD)/phy_sf/
	if [ -e $(PWD)/phy_sf/phy_sf ]; then \
		mv $(PWD)/phy_sf/phy_sf $(TOOL_DIR)/$(PHY_SF); \
    else \
            echo "No phy_sf is generated."; \
	exit 1; \
	fi

clean:
	$(MAKE) -C $(PWD)/md5_encrypt/ clean
	$(MAKE) -C $(PWD)/crc_calculation/ clean
	$(MAKE) -C $(PWD)/create_image/ clean
	$(MAKE) -C $(PWD)/phy_sf/ clean

