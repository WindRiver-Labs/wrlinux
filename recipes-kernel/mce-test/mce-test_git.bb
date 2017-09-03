#
# Copyright (C) 2012 Wind River Systems, Inc.
#
SUMMARY = "MCE test suite"

DESCRIPTION = "The MCE test suite is a collection of tools and test scripts for \
testing the Linux RAS related features, including CPU/Memory error \
containment and recovery, ACPI/APEI support etc."

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3"

PR = "r2"

SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/mce-test.git;protocol=git \
           file://makefile-remove-ldflags.patch \
          "
# Use the commit date of SRCREV in PV.
#
SRCREV = "b3fdfaa7a025b68f30913c9cc7a8fe4ae9c7ed7f"
PE = "1"
PV = "20131218+git${SRCPV}"

RDEPENDS_${PN} = "mcelog mce-inject dialog bash"

COMPATIBLE_HOST = '(i.86|x86_64).*-linux'

S ="${WORKDIR}/git"

inherit autotools-brokensep

do_install_append(){
   install -d ${D}/opt/mce-test
   cp -rf ${S}/* ${D}/opt/mce-test/
}

FILES_${PN} += "/opt"
FILES_${PN}-dbg += "/opt/mce-test/cases/function/hwpoison/.debug"
FILES_${PN}-dbg += "/opt/mce-test/cases/function/erst-inject/.debug"
FILES_${PN}-dbg += "/opt/mce-test/cases/function/pfa/.debug"
FILES_${PN}-dbg += "/opt/mce-test/cases/function/core_recovery/.debug"
FILES_${PN}-dbg += "/opt/mce-test/cases/stress/hwpoison/bin/.debug"
FILES_${PN}-dbg += "/opt/mce-test/cases/stress/hwpoison/tools/page-poisoning/.debug"
FILES_${PN}-dbg += "/opt/mce-test/cases/stress/hwpoison/tools/fs-metadata/.debug"
FILES_${PN}-dbg += "/opt/mce-test/bin/.debug"
FILES_${PN}-dbg += "/opt/mce-test/tools/ltp-pan/.debug"
FILES_${PN}-dbg += "/opt/mce-test/tools/simple_process/.debug"
FILES_${PN}-dbg += "/opt/mce-test/tools/page-types/.debug"
