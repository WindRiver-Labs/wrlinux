require nagios-common.inc

DESCRIPTION = "Nagios Service Check Acceptor"
HOMEPAGE = "http://exchange.nagios.org"
SECTION = "console/network"
PRIORITY = "optional"
LICENSE = "GPLv2"

LIC_FILES_CHKSUM = "file://src/nsca.c;beginline=1;endline=16;md5=857b620615a8977941350834081d880b"

SRCNAME = "nsca"

SRC_URI = "http://prdownloads.sourceforge.net/sourceforge/nagios/${SRCNAME}-${PV}.tar.gz \
           file://init-script.in \
           file://nagios-nsca.service \
           file://0001-Fix-missing-argument-in-open-calls.patch \
"

SRC_URI[md5sum] = "3fe2576a8cc5b252110a93f4c8d978c6"
SRC_URI[sha256sum] = "fb12349e50838c37954fe896ba6a026c09eaeff2f9408508ad7ede53e9ea9580"

S = "${WORKDIR}/${SRCNAME}-${PV}"

inherit update-rc.d autotools-brokensep systemd

DEPENDS = "libmcrypt"

EXTRA_OECONF += "--with-nsca-user=${NAGIOS_USER} \
                 --with-nsca-group=${NAGIOS_GROUP} \
                 --with-libmcrypt-prefix=${STAGING_DIR_HOST} \
                 ac_cv_path_LIBMCRYPT_CONFIG=${STAGING_BINDIR_CROSS}/libmcrypt-config \
                 ac_cv_lib_wrap_main=no \
                 ac_cv_path_PERL=${bindir}/perl \
"

do_configure() {
    cp ${WORKDIR}/init-script.in ${S}/init-script.in
    oe_runconf || die "make failed"
}

do_install() {
    CONF_DIR=${D}${NAGIOS_CONF_DIR}

    install -d ${CONF_DIR}
    install -d ${D}${sysconfdir}/init.d
    install -d ${D}${bindir}

    install -m 755 ${S}/sample-config/nsca.cfg ${CONF_DIR}
    install -m 755 ${S}/sample-config/send_nsca.cfg ${CONF_DIR}
    install -m 755 ${S}/init-script ${D}${sysconfdir}/init.d/nsca

    install -m 755 ${S}/src/nsca ${D}${bindir}
    install -m 755 ${S}/src/send_nsca ${D}${bindir}

    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -d ${D}${systemd_unitdir}/system
        install -m 644 ${WORKDIR}/nagios-nsca.service ${D}${systemd_unitdir}/system/
    fi
}

PACKAGES = "${PN}-dbg ${PN}-daemon ${PN}-client"

FILES_${PN}-daemon = "${sysconfdir}/init.d \
                      ${NAGIOS_CONF_DIR}/nsca.cfg \
                      ${bindir}/nsca \
"

FILES_${PN}-client = "${NAGIOS_CONF_DIR}/send_nsca.cfg \
                      ${bindir}/send_nsca \
"

RDEPENDS_${PN}-daemon += "libmcrypt \
                          nagios-base \
"
RDEPENDS_${PN}-client += "libmcrypt \
                          nagios-base \
"

SYSTEMD_PACKAGES = "${PN}-daemon"
SYSTEMD_SERVICE_${PN}-daemon = "nagios-nsca.service"
SYSTEMD_AUTO_ENABLE_${PN}-daemon = "enable"

INITSCRIPT_PACKAGES = "${PN}-daemon"
INITSCRIPT_NAME_${PN}-daemon = "nsca"
INITSCRIPT_PARAMS_${PN}-daemon = "defaults"
