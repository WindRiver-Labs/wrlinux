#
# Copyright (C) 2013 - 2021 Wind River Systems, Inc.
#
require recipes-kernel/linux-libc-headers/linux-libc-headers.inc

KERNEL_HEADER_DIR ??= "/usr-alt"
PROVIDES = "${@bb.utils.contains("KERNEL_HEADER_DIR", "/usr", "linux-libc-headers", "", d)}"
includedir = "${KERNEL_HEADER_DIR}/include"

# The version of the customized kernel should be specified here, for example,
LINUX_VERSION ?= "5.10.25"
LINUX_VERSION_EXTENSION_append = "-custom"

KBRANCH ?= "v5.10/standard/base"
SRCREV_machine = "${AUTOREV}"
PV = "${LINUX_VERSION}+git${SRCPV}"

# The location of the customized kernel should be specified here, for example,
KSRC_linux_libc_headers_custom = "${THISDIR}/../../../git/linux-yocto.git"
SRC_URI = "git://${KSRC_linux_libc_headers_custom};protocol=file;branch=${KBRANCH};name=machine"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

S = "${WORKDIR}/git"

FILES_${PN}-dev += "${KERNEL_HEADER_DIR}"

# To install headers to KERNEL_HEADER_DIR, use this do_install overwrites the
# one in oe-core.
do_install() {
	oe_runmake headers_install INSTALL_HDR_PATH=${D}${KERNEL_HEADER_DIR}
	# Kernel should not be exporting this header
	rm -f ${D}${exec_prefix}/include/scsi/scsi.h

	# The ..install.cmd conflicts between various configure runs
	find ${D}${includedir} -name ..install.cmd | xargs rm -f
}
