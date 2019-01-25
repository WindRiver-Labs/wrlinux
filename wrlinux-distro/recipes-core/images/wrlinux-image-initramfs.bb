#
# Copyright (C) 2012-2013 Wind River Systems, Inc.
#
DESCRIPTION = "A basic initramfs image that boots to a console."

LICENSE = "MIT"

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"

inherit wrlinux-image

IMAGE_INSTALL_INITRAMFS += "packagegroup-core-boot-wrs shadow libgcc"
IMAGE_LINGUAS = ""

QB_DEFAULT_FSTYPE = "cpio.gz"

export IMAGE_BASENAME = "wrlinux-image-initramfs"

# Use PACKAGE_INSTALL to only install specific packages
PACKAGE_INSTALL = "${IMAGE_INSTALL_INITRAMFS}"

USE_DEVFS = "0"

# grub_efi is only available for x86
#
python () {
    import re
    target = d.getVar('TARGET_ARCH', True)
    if target.startswith('x86') or re.match('i.86', target):
        deps = ' grub-efi:do_populate_lic'
        d.appendVarFlag('do_image_complete', 'depends', deps)
}
