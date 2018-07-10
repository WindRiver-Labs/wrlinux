#
# Copyright (C) 2014 Wind River Systems, Inc.
#
require ${BPN}.inc

SRC_URI += "git://pagure.io/microcode_ctl.git;protocol=https;branch=gone \
	    file://0001-add-the-WRLinux-release-support.patch \
            file://microcode_ctl.service \
            file://0001-fix-the-help-return-code.patch \
            file://fix-No-GNU_HASH-in-the-elf-binary.patch \
	   "

SRCREV = "ad1238f26ca54ffb2e1a19d53edfc8e0cea07416"

PV = "v2.1-9+git${SRCREV}"

S = "${WORKDIR}/git"
