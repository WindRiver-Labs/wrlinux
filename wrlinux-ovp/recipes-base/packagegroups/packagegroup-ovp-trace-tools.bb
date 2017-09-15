#
# Copyright (C) 2013 Wind River Systems, Inc.
#
DESCRIPTION = "Trace tools packagegroup extending glibc_std."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PACKAGES = "\
    ${PN} \
    ${PN}-dbg \
    ${PN}-dev \
    "
PACKAGE_ARCH = "${MACHINE_ARCH}"

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} = "\
    diod \
    trace-cmd \
    socat \
"
