inherit core-image

DESCRIPTION = "wrlinux glibc core rootfs...."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=3f40d7994397109285ec7b81fdeb3b58 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

EXTRA_IMAGE_FEATURES += "debug-tweaks"

# if mc is removed from task-core-basic-utils, this generates an image of 29M when last tested
IMAGE_INSTALL = "task-core-boot task-core-initscripts  task-core-basic-utils"

