#!/bin/sh
#
# Copyright (c) 2021 Wind River Systems, Inc.
#
# SPDX-License-Identifier:  GPL-2.0
#
wrimg=$1
uboot=$2
dev=$3

print_help() {
    echo Usage:
    echo $0 wrlinux-*.ustart.img.gz octeontx-bootfs-uboot-t96.img /dev/sdX
    echo
    exit 1
}

if [ $# -ne 3 -o ! -e "$dev" ]; then
    print_help
fi

echo $wrimg | grep -q ustart.img.gz
if [ $? -ne 0 -o ! -e $wrimg ]; then
    echo "The wrlinux image $wrimg is invalid or doesn't exist"
    exit 1
fi

if [ ! -e $uboot ]; then
    echo "The u-boot image $uboot doesn't exist"
    exit 1
fi

if [ ! -e $dev ]; then
    echo "The device doesn't exist: $dev "
    exit 1
fi

echo "Writing $wrimg and $uboot to $dev"
echo -n "Are you sure to destroy all data on $dev?(Y/N) "
read confirm
if [ "$confirm" != "y" -a "$confirm" != "Y" ]; then
    echo Aborted
    exit 1
fi

echo "umount $dev*"
sudo umount $dev*
zcat $wrimg | sudo dd of=$dev bs=1M status=progress conv=fsync
sudo dd if=$uboot of=$dev bs=512 seek=128 skip=128 conv=fsync
sudo losetup -f -P $uboot
uboot_dev=`losetup -j $uboot | sed -e '1q' | sed -e 's/:.*//'`
sudo partprobe $uboot_dev
sudo partprobe $dev
mkdir -p uboot_mnt && sudo mount $uboot_dev"p1" ./uboot_mnt
mkdir -p wrboot && sudo mount ${dev}1 ./wrboot && sudo cp -r ./uboot_mnt/* ./wrboot/
sudo umount $uboot_dev"p1" wrboot; sudo losetup -d $uboot_dev
rm -fr uboot_mnt wrboot
