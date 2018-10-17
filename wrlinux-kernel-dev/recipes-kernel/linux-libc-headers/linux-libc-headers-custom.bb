#
# Copyright (C) 2013 - 2018 Wind River Systems, Inc.
#
require recipes-kernel/linux-libc-headers/linux-libc-headers.inc

PROVIDES = "${@bb.utils.contains("KERNEL_HEADER_DIR", "/usr", "linux-libc-headers", "", d)}"

LINUX_VERSION ?= "4.18.9"
LINUX_VERSION_EXTENSION_append = "-custom"

KBRANCH ?= "v4.18/standard/base"
SRCREV_machine = "${AUTOREV}"
PV = "${LINUX_VERSION}+git${SRCPV}"

KSRC_linux_libc_headers_custom ?= "${THISDIR}/../../../git/linux-yocto-4.18.git"
SRC_URI = "git://${KSRC_linux_libc_headers_custom};protocol=file;branch=${KBRANCH};name=machine"

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
