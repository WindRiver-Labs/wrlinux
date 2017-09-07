#
# Copyright (C) 2017 Wind River Systems, Inc.
#
DESCRIPTION = "criu packagegroup"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
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
