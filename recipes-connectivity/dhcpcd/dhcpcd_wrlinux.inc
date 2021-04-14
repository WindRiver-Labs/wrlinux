FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://dhcpcd.service \
            file://dhcpcd-systemd-wrapper \
           "

do_install_append () {
    install -d ${D}${sysconfdir}/default
    echo 'INTERFACES="eth0"' > ${D}${sysconfdir}/default/dhcpcd

    install -d ${D}${base_sbindir}
    install -m 0755 ${WORKDIR}/dhcpcd-systemd-wrapper ${D}${base_sbindir}/dhcpcd-systemd-wrapper

    sed -i -e 's,@SYSCONFDIR@,${sysconfdir},g' ${D}${systemd_unitdir}/system/dhcpcd.service
    sed -i -e 's,@SBINDIR@,${base_sbindir},g' ${D}${systemd_unitdir}/system/dhcpcd.service
}
