#
# Copyright (C) 2020 Wind River Systems, Inc.
#
DESCRIPTION = "A busybox based minimal image that boots to a console."

LICENSE = "MIT"

CONTAINER_CORE_BOOT ?= " \
    base-files \
    base-passwd \
    ${VIRTUAL-RUNTIME_update-alternatives} \
"

TARGET_CORE_BOOT ?= " \
    packagegroup-core-boot \
    dhcpcd \
    kernel-module-fuse \
    kernel-module-sch-fq-codel \
    glib-networking \
"

# Control the installed packages strictly
WRTEMPLATE_IMAGE = "0"

IMAGE_INSTALL = "\
    ${@bb.utils.contains('IMAGE_ENABLE_CONTAINER', '1', '${CONTAINER_CORE_BOOT}', '${TARGET_CORE_BOOT}', d)} \
    busybox \
    busybox-syslog \
    openssh \
    ca-certificates \
"

# - No packagegroup-core-base-utils which corresponds to busybox
#   function since it is busybox based.
# - The ostree are not needed for container image.
IMAGE_INSTALL_remove = "\
    packagegroup-core-base-utils \
    ${@bb.utils.contains('IMAGE_ENABLE_CONTAINER', '1', 'ostree ostree-upgrade-mgr linux-firmware', '', d)} \
"

# Only need tar.bz2 for container image
IMAGE_FSTYPES_remove = " \
    ${@bb.utils.contains('IMAGE_ENABLE_CONTAINER', '1', 'live wic wic.bmap ostreepush otaimg', '', d)} \
"

# For bcm-2xxx-rpi4
IMAGE_INSTALL_append_bcm-bcm-2xxx-rpi4 = " ${@bb.utils.contains_any('BBEXTENDCURR', 'multilib', '', 'u-boot', d)}"
IMAGE_INSTALL_append_bcm-2xxx-rpi4 = " boot-config"
IMAGE_INSTALL_append_bcm-2xxx-rpi4 = " ${@bb.utils.contains('OSTREE_BOOTLOADER', 'u-boot', 'u-boot-uenv', '', d)}"

IMAGE_FEATURES += "package-management"

inherit wrlinux-image
inherit extrausers

NO_RECOMMENDATIONS = "1"

# Set root password to root
EXTRA_USERS_PARAMS += "usermod -P root root;"

# Remove debug-tweaks
EXTRA_IMAGE_FEATURES = ""
