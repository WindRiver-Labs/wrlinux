#
# Copyright (C) 2016 Wind River Systems, Inc.
#
SUMMARY = "Credential storage for utilities that implement the askpass interface"

DESCRIPTION = "anspass is a daemon/client utility to save and retrieve \
    credentials by other utilities that implement the askpass interface."

LICENSE = "LGPLv2"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=4fbd65380cdd255951079008b364516c"

DEPENDS = "libgcrypt"

SRC_URI = "git://github.com/WindRiver-OpenSourceLabs/anspass"

SRCREV = "726c141fe582add0addf7d128aa33d1e3c532b56"

PV = "1.0+git${SRCPV}"

inherit autotools-brokensep

S = "${WORKDIR}/git"

BBCLASSEXTEND = "native nativesdk"
