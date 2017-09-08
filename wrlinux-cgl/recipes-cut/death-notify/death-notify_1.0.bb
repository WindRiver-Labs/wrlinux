#
# Copyright (C) 2013 Wind River Systems, Inc.
#
SUMMARY = "death-notify"
DESCRIPTION = "The death-notify package contains a Hello World program"
SECTION = "apps"
LICENSE = "windriver"
LIC_FILES_CHKSUM = "file://license;md5=8cc536f28ecdfef562344c9fe2222252"

SRC_URI = "\
	file://files/license \
	file://files/death-notify.c \
	file://files/Makefile \
	file://files/death-notify-test \
	"

do_patch() {
	cp -r ${WORKDIR}/files/* ${S}
}

do_install() {
	mkdir -p ${D}/opt/cut/bin
	install -m 0755 ${S}/death-notify ${D}/opt/cut/bin

	mkdir -p ${D}/opt/cut/scripts
	install -m 0755 ${S}/death-notify-test ${D}/opt/cut/scripts
}

# death-notify-test needs this
#
RDEPENDS_${PN} += "bash"

FILES_${PN} += "/opt/cut/*"
FILES_${PN}-dbg += "/opt/cut/bin/.debug"
