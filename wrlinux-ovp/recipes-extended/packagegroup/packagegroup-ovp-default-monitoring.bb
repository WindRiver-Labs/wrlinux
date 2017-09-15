# Copyright (C) 2015 Wind River Systems, Inc.
#
DESCRIPTION = "OVP Default Monitoring System"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
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
