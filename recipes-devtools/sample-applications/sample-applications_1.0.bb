#
# Copyright (C) 2021 Wind River Systems, Inc.
#
SUMMARY = "Add sample applications for out-of-box support in SDKs"

DESCRIPTION = "Add sample applications for out-of-box support in SDKs."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "file://sample-applications"

S="${WORKDIR}"

do_install() {
    install -d ${D}/usr/share
    cp -R --no-dereference --preserve=mode,links -v ${WORKDIR}/sample-applications/ ${D}/usr/share
}

# Package in the SDK
FILES_${PN}-dev += "/usr/share"

ALLOW_EMPTY_${PN} = "1"
