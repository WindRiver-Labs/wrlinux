#
# Copyright (C) 2017 Wind River Systems, Inc.
#
DESCRIPTION = "docker packagegroup"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PACKAGES = "\
    ${PN} \
    "
ALLOW_EMPTY_${PN} = "1"

DOCKER_PKGS = "\
    docker \
    docker-registry \
"

RDEPENDS_${PN}_x86-64 = "\
    ${DOCKER_PKGS} \
"
