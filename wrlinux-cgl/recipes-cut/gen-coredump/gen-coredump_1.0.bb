#
# Copyright (C) 2013 Wind River Systems, Inc.
#
SUMMARY = "gen-coredump"
DESCRIPTION = "The gen-coredump package contains a gen_coredump program"
SECTION = "apps"
LICENSE = "windriver"
LIC_FILES_CHKSUM = "file://license;md5=8cc536f28ecdfef562344c9fe2222252"

SRC_URI = "\
	file://files/license \
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
