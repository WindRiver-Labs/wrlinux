#
# Copyright (C) 2012-2013 Wind River Systems, Inc.
#
# Based on packagegroup-core-boot.bb of yocto
#

DESCRIPTION = "Package Group for wrlinux - minimal bootable image"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
PACKAGE_ARCH = "${MACHINE_ARCH}"

ALLOW_EMPTY_${PN} = "1"
PR = "r1"

# Distro can override the following VIRTUAL-RUNTIME providers:
VIRTUAL-RUNTIME_dev_manager ?= "udev"
VIRTUAL-RUNTIME_login_manager ?= "busybox"
VIRTUAL-RUNTIME_init_manager ?= "sysvinit"
VIRTUAL-RUNTIME_initscripts ?= "initscripts"
VIRTUAL-RUNTIME_keymaps ?= "keymaps"

PACKAGES = "\
    packagegroup-core-boot-wrs \
    packagegroup-core-boot-wrs-dbg \
    packagegroup-core-boot-wrs-dev \
"

RDEPENDS_packagegroup-core-boot-wrs = "\
    base-files \
    base-passwd \
    busybox \
    ${VIRTUAL-RUNTIME_initscripts} \
    ${@bb.utils.contains("MACHINE_FEATURES", "keyboard", "${VIRTUAL-RUNTIME_keymaps}", "", d)} \
    modutils-initscripts \
    netbase \
    ${VIRTUAL-RUNTIME_login_manager} \
    ${VIRTUAL-RUNTIME_init_manager} \
    ${VIRTUAL-RUNTIME_dev_manager} \
    ${VIRTUAL-RUNTIME_update-alternatives} \
"
