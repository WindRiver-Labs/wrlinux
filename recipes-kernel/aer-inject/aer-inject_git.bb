#
# Copyright (C) 2012 Wind River Systems, Inc.
#
SUMMARY = "inject PCIE AER errors on the software level"

DESCRIPTION = "aer-inject allows to inject PCIE AER errors on the software level into \
a running Linux kernel. This is intended for validation of the PCIE \
driver error recovery handler and PCIE AER core handler."

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://README;md5=95cd6a39bf9e2981abfc7c7cfaf5d6dd"

PR = "r1"

SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git;protocol=git \
           file://include-libgen-version-of-basename-function.patch \
          "

# Use the commit date of SRCREV in PV.
#
SRCREV = "9bd5e2c7886fca72f139cd8402488a2235957d41"
PE = "1"
PV = "20100310+git${SRCPV}"

DEPENDS = "flex-native"

S ="${WORKDIR}/git"

do_install(){
    install -d ${D}${bindir}
    install -m 0755 ${S}/aer-inject ${D}${bindir}
}
