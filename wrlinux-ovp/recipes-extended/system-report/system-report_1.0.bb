#
# Copyright (C) 2013 Wind River Systems, Inc.
#
SUMMARY = "Generate various system information report of this system"
DESCRIPTION = "SystemReporter is a simple tool which gathers/crawls \
 various system files, uses various helper tools to obtain relevant \
 system information. The gathered information is grouped, and is shown \
 on the console."
SECTION = "console/utils"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://systemReporter.py"
DEPENDS = "python"
RDEPENDS_${PN} = "dmidecode"

S = "${WORKDIR}"

do_install() {
    install -d ${D}/usr/bin
    install -m 755 systemReporter.py ${D}/usr/bin/systemReporter
}

COMPATIBLE_HOST = "(i.86|x86_64|aarch64|arm|powerpc|powerpc64).*-linux"
