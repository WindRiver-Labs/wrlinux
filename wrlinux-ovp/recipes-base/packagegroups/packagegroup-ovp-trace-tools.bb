#
# Copyright (C) 2013 Wind River Systems, Inc.
#
DESCRIPTION = "Trace tools packagegroup extending glibc_std."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
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
