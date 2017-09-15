#
# Copyright (C) 2012 Wind River Systems, Inc.
#
DESCRIPTION = "Wind River Linux GNU-based (non-busybox) core root filesystem"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PR = "r2"


IMAGE_INSTALL = " \
    packagegroup-wr-boot \
    packagegroup-wr-base \
    packagegroup-wr-base-net \
    ${@bb.utils.contains('IMAGE_ENABLE_CONTAINER', '1', '', 'kernel-modules', d)} \
"

inherit wrlinux-image

NO_RECOMMENDATIONS_task-rootfs = "1"
