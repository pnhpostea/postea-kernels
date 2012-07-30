#!/bin/sh

TAR_NAME=~/work/GT-I9100_Kernel_ICS-postea.$1.tar

INITRAMFS_SOURCE=`readlink -f ~/work/postea_kernels/initramfs_root`
INITRAMFS_TMP="/tmp/initramfs-source"


rm -rf $INITRAMFS_TMP
cp -ax $INITRAMFS_SOURCE $INITRAMFS_TMP
find $INITRAMFS_TMP -name .git -exec rm -rf {} \;

export ARCH=arm
export CROSS_COMPILE=/home/proiam/work/utils/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
export USE_SEC_FIPS_MODE=true

export LOCALVERSION="POSTEA"
export KBUILD_BUILD_VERSION="r$1"

#cp samsung-kernel-galaxysii/.config ./.config.$1

echo "|========================================================================|"
echo "| Build everything, make yourself a coffee if this is the first time you |"
echo "| run this or after you do \"make clean\"                                  |"
echo "|========================================================================|"

cd GT-I9100_Kernel/
#Make modules never work the first time, so just make everything first.
nice -n 10 make -j8 || exit 1
find -name '*.ko' -exec cp -av {} $INITRAMFS_TMP/lib/modules/ \;

echo "|========================================================================|"
echo "| Build initramfs/cpio                                                   |"
echo "|========================================================================|"

cd $INITRAMFS_TMP
find | fakeroot cpio -H newc -o > $INITRAMFS_TMP.cpio 2>/dev/null
ls -lh $INITRAMFS_TMP.cpio
cd -

echo "|========================================================================|"
echo "| Build zImage, and tar archive for flashing                             |"
echo "|========================================================================|"

nice -n 10 make -j8 zImage  CONFIG_INITRAMFS_SOURCE="$INITRAMFS_TMP.cpio" || exit 1
cd arch/arm/boot
tar cf $TAR_NAME zImage && ls -lh $TAR_NAME

echo ">>>>>>>>>> DONE!"
