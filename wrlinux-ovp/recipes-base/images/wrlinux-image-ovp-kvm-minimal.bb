#
# Copyright (C) 2017 Wind River Systems, Inc.
#
DESCRIPTION = "An image suitable for a minimal KVM guest or host."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"


inherit wrlinux-image

IMAGE_INSTALL = " \
   packagegroup-core-boot \
   packagegroup-ovp-vm \
   packagegroup-containers \
"
