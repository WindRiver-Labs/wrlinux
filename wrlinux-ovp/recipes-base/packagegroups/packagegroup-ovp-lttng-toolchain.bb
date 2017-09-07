#
# Copyright (C) 2014 Wind River Systems, Inc.
#
DESCRIPTION = "OVP LTTng Toolchain"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

RDEPENDS_${PN} = "\
	lttng-tools \
	babeltrace \
	lttng-ust \
"
