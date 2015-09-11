#!/bin/sh

set -e

# toolchain
INFOTM_TC=${INFOTM_TC:-../toolchain_infotm_1.2.2/bin/arm-infotm-linux-gnueabi-}

INITRD_PATH=${INITRD_PATH:-../uinitrd-kirkwood}

MKIMAGE_PATH=${MKIMAGE_PATH:-../mkimage}

# clean initrd directory
rm -rf ${INITRD_PATH}/lib/{modules,firmware}
# build kernel for the first time
make KALLSYMS_EXTRA_PASS=1 ARCH=arm CROSS_COMPILE=${INFOTM_TC} -j2 zImage
# build modules against the kernel
make KALLSYMS_EXTRA_PASS=1 ARCH=arm CROSS_COMPILE=${INFOTM_TC} -j2 modules
# install modules into initramfs dir
make ARCH=arm CROSS_COMPILE=${INFOTM_TC} -j2 modules_install INSTALL_MOD_PATH=${INITRD_PATH}/
# install firmware to initramfs folder
make ARCH=arm CROSS_COMPILE=${INFOTM_TC} -j2 firmware_install INSTALL_MOD_PATH=${INITRD_PATH}/
# remove unnecessary files
rm -rf ${INITRD_PATH}/lib/modules/3.4.*/{build,source}
# build the kernel again, with initramfs dir contains modules
make KALLSYMS_EXTRA_PASS=1 ARCH=arm CROSS_COMPILE=${INFOTM_TC} -j2 zImage
# make u-boot image
${MKIMAGE_PATH} -A arm -C none -O linux -T kernel -a 0x40008000 -e 0x40008000 -n linux-3.4 -d arch/arm/boot/zImage arch/arm/boot/uImage
# make firmware2
firmwareFileName=`date +%H%M_%F`-firmware2
dd if=/dev/zero of=${firmwareFileName} bs=1 count=192
cat arch/arm/boot/uImage >> ${firmwareFileName}
