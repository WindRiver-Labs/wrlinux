#
# Copyright (C) 2013 Wind River Systems, Inc.
#
SUMMARY = "gen-coredump"
DESCRIPTION = "The gen-coredump package contains a gen_coredump program"
SECTION = "apps"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e"

SRC_URI = "\
	file://files/COPYING \
	file://files/gen_coredump.c \
	file://files/mthread.c \
	file://files/Makefile \
	file://files/backtrace_01.c \
	file://files/memtrace_01.c \
	"

# Avoid generated binaries stripping. Otherwise the CUT gdb test fails
INHIBIT_PACKAGE_STRIP = "1"

do_patch() {
	cp -r ${WORKDIR}/files/* ${S}
}

do_install() {
	mkdir -p ${D}/opt/cut/bin
	install -m 0755 ${S}/gen_coredump ${D}/opt/cut/bin
	install -m 0755 ${S}/mthread ${D}/opt/cut/bin
	install -m 0755 ${S}/backtrace ${D}/opt/cut/bin
	install -m 0755 ${S}/memtrace ${D}/opt/cut/bin
}

FILES_${PN} += "/opt/cut/*"
FILES_${PN}-dbg += "/opt/cut/bin/.debug"
