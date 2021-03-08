DESCRIPTION = "Virtual/monitoring for nagios packages"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

require packagegroup-monitoring.inc

RDEPENDS_${SRCNAME}-core += "\
    nagios-base \
    nagios-core-setup \
    nagios-core \
    nagios-plugins \
    nagios-nrpe-plugin \
    nagios-nsca-daemon \
"

RDEPENDS_${SRCNAME}-agent += "\
    nagios-base \
    nagios-plugins \
    nagios-nrpe-daemon \
    nagios-nsca-client \
"

COMPATIBLE_HOST_aarch64 = "null"
