#
# Copyright (C) 2013 Wind River Systems, Inc.
#
SUMMARY = "cyclictest"
DESCRIPTION = "The cyclictest package contains a Hello World program"
SECTION = "apps"
LICENSE = "windriver"
LIC_FILES_CHKSUM = "file://license;md5=8cc536f28ecdfef562344c9fe2222252"

SRC_URI = "\
	file://files/license \
	file://files/cyclic-test \
	file://files/cyclictest.c \
	file://files/Makefile \
	"

do_patch() {
	cp -r ${WORKDIR}/files/* ${S}
}

do_install() {
	mkdir -p ${D}/opt/cut/bin
	install -m 0755 ${S}/cyclictest ${D}/opt/cut/bin

	mkdir -p ${D}/opt/cut/scripts
	install -m 0755 ${S}/cyclic-test ${D}/opt/cut/scripts
}

# cyclic-test needs this
#
RDEPENDS_${PN} += "bash"

FILES_${PN} += "/opt/cut/*"
FILES_${PN}-dbg += "/opt/cut/bin/.debug"
