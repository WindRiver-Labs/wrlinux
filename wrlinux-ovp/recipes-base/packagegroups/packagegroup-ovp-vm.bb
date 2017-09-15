#
# Copyright (C) 2017 Wind River Systems, Inc.
#
DESCRIPTION = "Packagegroup for VM"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

RDEPENDS_${PN} = "\
    qemu \
"

RRECOMMENDS_${PN} = " \
    kernel-module-kvm \
    kernel-module-kvm-intel \
    kernel-module-kvm-amd \
"

COMPATIBLE_HOST_mips64 = "null"
