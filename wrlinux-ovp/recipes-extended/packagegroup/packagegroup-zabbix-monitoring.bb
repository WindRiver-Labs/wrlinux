DESCRIPTION = "Virtual/monitoring for zabbix packages"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

require packagegroup-monitoring.inc

RDEPENDS_${SRCNAME}-core = "\
    zabbix-server-pgsql \
    zabbix-frontend-php \
"

RDEPENDS_${SRCNAME}-agent = "\
    zabbix-agent \
"

RDEPENDS_${SRCNAME}-proxy = "\
    zabbix-proxy-pgsql \
"
