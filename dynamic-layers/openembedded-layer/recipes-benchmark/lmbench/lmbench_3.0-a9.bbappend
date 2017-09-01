#
# Copyright (C) 2014 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${P}:"

SRC_URI += "file://lmbench-3.0-a9_wr_integration.patch \
            file://wr-lmbench-test.sh \
            file://upload-rth.sh \
            file://dealt_log.sh \
            file://README \
            file://generate_report.sh \
            file://scripts/sysinfo_lib.sh \
            file://scripts/utility.sh \
            file://config/default_case_conf \
            file://config/default_group_conf \
            file://config/template \
"

WR_LMBENCH ?= "/opt/benchmark/os/wr-lmbench"

inherit update-alternatives

do_install_append () {
	install -d ${D}/${WR_LMBENCH}
	install -m 0755 ${WORKDIR}/wr-lmbench-test.sh ${D}/${WR_LMBENCH}
	install -m 0755 ${WORKDIR}/upload-rth.sh ${D}/${WR_LMBENCH}
	install -m 0755 ${WORKDIR}/dealt_log.sh ${D}/${WR_LMBENCH}
	install -m 0755 ${WORKDIR}/generate_report.sh ${D}/${WR_LMBENCH}
	install -m 0664 ${WORKDIR}/README ${D}/${WR_LMBENCH}/
	cp -r ${WORKDIR}/config ${D}/${WR_LMBENCH}/
	cp -r ${WORKDIR}/scripts ${D}/${WR_LMBENCH}/
	mv ${D}${bindir}/hello ${D}${bindir}/hello.lmbench
}

ALTERNATIVE_${PN} = "hello"
ALTERNATIVE_PRIORITY = "100"
ALTERNATIVE_LINK_NAME[hello] = "${bindir}/hello"
ALTERNATIVE_TARGET[hello] = "${bindir}/hello.lmbench"

FILES_${PN} += "${WR_LMBENCH}"

RDEPENDS_${PN} += "bash"
