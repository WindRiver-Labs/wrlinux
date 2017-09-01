#
# Copyright (C) 2012 Wind River Systems, Inc.
#
# LOCAL REV: WR specific settings for inittab
#
# make the default runlevel 3
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI = "file://inittab"
RDEPENDS_${PN} += "mingetty"
SYSVINIT_ENABLED_GETTYS = "2 3 4 5 6"

# override the do_install to remove the multiple serial port
# consoles setting and use 'mingetty console' instead just
# as what we did in previous wrlinux versions.
do_install() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/inittab ${D}${sysconfdir}/inittab

    if [ "${USE_VT}" = "1" ]; then
        cat <<EOF >>${D}${sysconfdir}/inittab
# ${base_sbindir}/mingetty invocations for the runlevels.
#
# The "id" field MUST be the same as the last
# characters of the device (after "tty").
#
# Format:
#  <id>:<runlevels>:<action>:<process>
#

EOF

        for n in ${SYSVINIT_ENABLED_GETTYS}
        do
            echo "$n:2345:respawn:${base_sbindir}/mingetty tty$n" >> ${D}${sysconfdir}/inittab
        done
        echo "" >> ${D}${sysconfdir}/inittab
    fi
    echo "l5:5:wait:/etc/init.d/rc 5" >> ${D}${sysconfdir}/inittab


}

# remove the serial check in post install script
pkg_postinst_${PN} () {
    :
}
