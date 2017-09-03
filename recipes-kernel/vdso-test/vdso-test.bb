#
# Copyright (C) 2014 Wind River Systems, Inc.
#
SUMMARY = " Vdso test Tool"
DESCRIPTION = "the vdso test tool is used for vdso_gettimeofday,vdso_time and vdso_clock_gettime test\
 - vdso_test-x86 is for x86 \
 - vdso_test-x86_64 is for x86-64 \
"

SECTION = "vdso test"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "\
	file://vdso.c \ 
	file://0001-test-app-patch-x86-vdso-time-support-for-32-bit-kern.patch \
	file://parse_vdso.c \
	file://vdso_test.c \
	file://0001-test-app-patch-x86-vdso-time-support-for-64-bit-kern.patch \
	"

S = "${WORKDIR}"

inherit siteinfo

do_compile() {
 	if [ "${SITEINFO_BITS}" = "64" ]; then
	  ${CC} -std=gnu99 -nostdlib -Os -fno-asynchronous-unwind-tables -flto vdso_test.c parse_vdso.c -o vdso_test-x86_64
	else
	  ${CC} ${LDFLAGS} vdso.c -o vdso_test-x86
	fi
}

do_install() {
	install -d ${D}${bindir}
 	if [ "${SITEINFO_BITS}" = "64" ]; then
	     install -m 0755 vdso_test-x86_64 ${D}${bindir}
	else
	     install -m 0755 vdso_test-x86 ${D}${bindir}
	fi
}

COMPATIBLE_HOST = '(x86_64.*|i.86.*)-linux' 
