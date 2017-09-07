NAGIOS_CONF_DIR = "${sysconfdir}/nagios"
NAGIOS_PLUGIN_DIR = "${libdir}/nagios/plugins"
NAGIOS_PLUGIN_CONF_DIR = "${NAGIOS_CONF_DIR}/plugins"
NAGIOS_STATE_DIR = "${localstatedir}/nagios"

NAGIOS_USER = "nagios"
NAGIOS_GROUP = "nagios"

EXTRA_OECONF += "--sysconfdir=${NAGIOS_CONF_DIR} \
                 --libexecdir=${NAGIOS_PLUGIN_DIR} \
                 --localstatedir=${NAGIOS_STATE_DIR} \
"

FILES_${PN}-dbg += "${NAGIOS_PLUGIN_DIR}/.debug"

DEPENDS = "nagios-core"

COMPATIBLE_HOST_aarch64 = "null"
