#
# Copyright (C) 2017 Wind River Systems, Inc.
#
DESCRIPTION = "criu packagegroup"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

CRIU_PKGS = "\
    criu \
    protobuf-c \
"

RDEPENDS_${PN}_x86-64 = "\
    ${CRIU_PKGS} \
"

RDEPENDS_${PN}_arm = "\
    ${CRIU_PKGS} \
"
