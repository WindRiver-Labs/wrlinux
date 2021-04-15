#
# Copyright (C) 2020 - 2021 Wind River Systems, Inc.
#
DESCRIPTION = "A busybox based minimal image that boots to a console."

require wrlinux-bin-image.inc

TARGET_CORE_BOOT ?= " \
    packagegroup-core-boot \
    dhcpcd \
    kernel-module-fuse \
    kernel-module-sch-fq-codel \
    glib-networking \
    systemd-extra-utils \
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
    ${@bb.utils.contains('IMAGE_ENABLE_CONTAINER', '1', 'u-boot u-boot-uenv boot-config', '', d)} \
"

# For ostree
IMAGE_INSTALL_append = " ${@bb.utils.contains('OSTREE_BOOTLOADER', 'u-boot', 'u-boot-uenv', '', d)}"

# For bcm-2xxx-rpi4
IMAGE_INSTALL_append_bcm-2xxx-rpi4 = " boot-config"

# For nxp-s32g2xx
IMAGE_INSTALL_append_nxp-s32g2xx = " u-boot-s32"

NO_RECOMMENDATIONS = "1"

# Remove debug-tweaks and x11-base
IMAGE_FEATURES_remove = "debug-tweaks x11-base"
