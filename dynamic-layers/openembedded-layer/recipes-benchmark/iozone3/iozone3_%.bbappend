#
# Copyright (C) 2014 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://diskdetect.sh \
            file://runtest.sh \
"

WR_IOZONE ?= "/opt/benchmark/fs/iozone/"

do_install_append() {
    install -d ${D}/${WR_IOZONE}
    install -m 0755 ${WORKDIR}/runtest.sh ${D}/${WR_IOZONE}
    install -m 0755 ${WORKDIR}/diskdetect.sh ${D}/${WR_IOZONE}
}

FILES_${PN} += "${WR_IOZONE}"
