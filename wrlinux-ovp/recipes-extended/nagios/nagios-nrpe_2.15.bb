require nagios-common.inc

DESCRIPTION = "Nagios Remote Plugin Executor"
HOMEPAGE = "http://exchange.nagios.org"
SECTION = "console/network"
PRIORITY = "optional"
LICENSE = "GPLv2"

LIC_FILES_CHKSUM = "file://src/nrpe.c;beginline=1;endline=19;md5=da42bb4163fc7634d567924d81a94e1a"

SRCNAME = "nrpe"

SRC_URI = "http://sourceforge.net/projects/nagios/files/${SRCNAME}-2.x/${SRCNAME}-2.15/${SRCNAME}-${PV}.tar.gz \
           file://fix-configure-uses-host-openssl.patch \
           file://fix-compile-without-openssl.patch \
           file://check_nrpe.cfg \
           file://nagios-nrpe.service \
"

SRC_URI[md5sum] = "3921ddc598312983f604541784b35a50"
SRC_URI[sha256sum] = "66383b7d367de25ba031d37762d83e2b55de010c573009c6f58270b137131072"

S = "${WORKDIR}/${SRCNAME}-${PV}"

inherit autotools update-rc.d systemd monitoring-hosts

EXTRA_OECONF += "--with-nrpe-user=${NAGIOS_USER} \
                 --with-nrpe-group=${NAGIOS_GROUP} \
                 ac_cv_lib_wrap_main=no \
                 ac_cv_path_PERL=${bindir}/perl \
"

EXTRA_OECONF_SSL = "--with-ssl=${STAGING_DIR_HOST} \
                    --with-ssl-inc=${STAGING_DIR_HOST}${includedir} \
                    --with-ssl-lib=${STAGING_DIR_HOST}${libdir} \
"

PACKAGECONFIG[ssl] = "${EXTRA_OECONF_SSL},--disable-ssl,openssl,"
PACKAGECONFIG[cmdargs] = "--enable-command-args,--disable-command-args,,"
PACKAGECONFIG[bashcomp] = "--enable-bash-command-substitution,--disable-bash-command-substitution,,"

PACKAGECONFIG ??= "ssl cmdargs bashcomp"

do_configure() {
    oe_runconf || die "make failed"
    ${STAGING_BINDIR_NATIVE}/openssl dhparam -C 512 | awk '/^-----/ {exit} {print}' > ${S}/include/dh.h
}

do_install_append() {
    oe_runmake 'DESTDIR=${D}' install-daemon-config

    install -d ${D}${sysconfdir}/init.d
    install -m 755 ${B}/init-script.debian ${D}${sysconfdir}/init.d/nrpe

    install -d ${D}${NAGIOS_CONF_DIR}/nrpe.d
    echo "include_dir=${NAGIOS_CONF_DIR}/nrpe.d" >> ${D}${NAGIOS_CONF_DIR}/nrpe.cfg

    sed -e "s/^allowed_hosts=.*/allowed_hosts=${MONITORING_AGENT_SERVER_IP}/g" \
        -i ${D}${NAGIOS_CONF_DIR}/nrpe.cfg

    install -d ${D}${NAGIOS_PLUGIN_CONF_DIR}
    install -m 664 ${WORKDIR}/check_nrpe.cfg ${D}${NAGIOS_PLUGIN_CONF_DIR}

    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -d ${D}${systemd_unitdir}/system
        install -m 755 ${WORKDIR}/nagios-nrpe.service ${D}${systemd_unitdir}/system/
    fi
}

PACKAGES = "${PN}-dbg ${PN}-plugin ${PN}-daemon"

FILES_${PN}-plugin = "${NAGIOS_PLUGIN_DIR} \
                      ${NAGIOS_PLUGIN_CONF_DIR} \
"

FILES_${PN}-daemon = "${sysconfdir} \
                      ${bindir} \
"

RDEPENDS_${PN}-daemon = "nagios-base"
RDEPENDS_${PN}-plugin = "nagios-base"

SYSTEMD_PACKAGES = "${PN}-daemon"
SYSTEMD_SERVICE_${PN}-daemon = "nagios-nrpe.service"
SYSTEMD_AUTO_ENABLE_${PN}-daemon = "enable"

INITSCRIPT_PACKAGES = "${PN}-daemon"
INITSCRIPT_NAME_${PN}-daemon = "nrpe"
INITSCRIPT_PARAMS_${PN}-daemon = "defaults"
