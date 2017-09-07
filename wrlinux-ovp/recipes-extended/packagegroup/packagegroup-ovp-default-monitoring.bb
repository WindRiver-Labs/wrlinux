# Copyright (C) 2015 Wind River Systems, Inc.
#
DESCRIPTION = "OVP Default Monitoring System"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

DEPENDS += "virtual/monitoring"

PACKAGES = "\
    ${PN} \
    ${PN}-dbg \
    ${PN}-dev \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} = "\
	${@bb.utils.contains('MONITORING_FEATURES', 'core', 'packagegroup-monitoring-core', '', d)} \
	${@bb.utils.contains('MONITORING_FEATURES', 'proxy', 'packagegroup-monitoring-proxy', '', d)} \
	${@bb.utils.contains('MONITORING_FEATURES', 'agent', 'packagegroup-monitoring-agent', '', d)} \
"

COMPATIBLE_HOST_aarch64 = "${@bb.utils.contains('MONITORING_FEATURES', 'nagios', 'null', '.*', d)}"
