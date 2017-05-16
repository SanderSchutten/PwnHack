#!/bin/bash 

echo "tar -zxvf SN986_1.60_QR_Scan_019a_20160606_0951.tgz"
echo "cd SN986_1.60_QR_Scan_019a_20160606_0951"
echo "./sdk.unpack"
echo "cd snx_sdk"
echo "mkdir patch"
echo "Place PwnHack in the folder 'Patch'"
echo "cd patch"
echo "./patch.sh" 

echo -e "** Xiaomi Xiaofang Custom firmware builder script **\n"



echo -e "Clean SDK"
/bin/rm -f -r ../snx_sdk/sdcard
mkdir ../snx_sdk/sdcard
cd ../snx_sdk/buildscript/
make clean
cd ../../PwnHack/
mkdir ../snx_sdk/rootfs
mkdir ../snx_sdk/rootfs-rescue

echo "Patching SDK files"
/bin/cp  -f -r ./snx_sdk/* ../snx_sdk/
echo -e " Done\n"

echo -e "Extracting firmware rootfs files"
mkdir /mnt/rootfs
mkdir /tmp/rootfs
mount  -o loop -t cramfs ./3.0.3.56/rootfs.cramfs /mnt/rootfs/ 
(cd /mnt/rootfs/ ; tar cfp - .)|(cd /tmp/rootfs/ ; tar xfp  - --warning=no-timestamp)
umount /mnt/rootfs
rmdir /mnt/rootfs
/bin/rm -f /tmp/rootfs/lib/modules/2.6.35.12/kernel/drivers/ar0130.ko
/bin/rm -f /tmp/rootfs/lib/modules/2.6.35.12/kernel/drivers/imx322.ko
/bin/rm -f /tmp/rootfs/lib/modules/2.6.35.12/kernel/drivers/ov9715.ko
/bin/rm -f /tmp/rootfs/lib/modules/2.6.35.12/kernel/drivers/sc2035.ko
mkdir -p ../snx_sdk/sdcard/usr/bin
/bin/cp -f /tmp/rootfs/usr/bin/smbclient ../snx_sdk/sdcard/usr/bin/
/bin/rm -f /tmp/rootfs/usr/bin/smbclient
echo -e " Done\n"


echo "Patching rootfs files"
/bin/cp  -f -r  rootfs/* /tmp/rootfs
echo -e " Done\n"


echo "Applying fanghack"
/bin/cp  -f -r  ./fanghack/rootfs/* /tmp/rootfs
/bin/cp  -f -r  ./fanghack/sdcard/* ../snx_sdk/sdcard/
echo -e " Done\n"

echo "Create cramfs" 
mkfs.cramfs /tmp/rootfs/ ../snx_sdk/image/rootfs.cramfs
/bin/rm -f -r /tmp/rootfs
echo " Done\n\n"


echo "Provisioning sdcard" 
/bin/cp -f -r ./sdcard/* ../snx_sdk/sdcard/
echo " Done\n\n"


echo "Providing nvram.bin"
/bin/cp -f ./needed/nvram.bin ../snx_sdk/image/
#/bin/cp -f ./needed/u-boot.bin ../snx_sdk/image/
echo -e " Done\n"


echo "Copying KERNEL.bin from source firmware"
/bin/cp -f ./3.0.3.56/KERNEL.bin ../snx_sdk/image/
echo -e "\tDone"

echo "Creating uImage file from KERNEL.bin"
dd if=../snx_sdk/image/KERNEL.bin of=../snx_sdk/image/uImage bs=1 skip=4 count=$(( $(stat -c %s ../snx_sdk/image/KERNEL.bin) - 116 )) iflag=skip_bytes,count_bytes
echo -e "\tDone\n"

echo "Duplicating uImage to rescue_uImage (for now)"
/bin/cp -f ../snx_sdk/image/uImage ../snx_sdk/image/rescue_uImage
echo -e "\tDone\n"


cd ../snx_sdk/buildscript/

make firmware
#make

echo -e "\n\n*******************************************************************"
echo -e "Copy the file FIRMWARE660-R.bin onto the root of an SDCard."
echo -e "Place the SDCard in the Xiaofang camera. Keep the setup button pressed during boot for 10 seconds."

