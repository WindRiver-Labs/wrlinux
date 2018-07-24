require nagios-common.inc

DESCRIPTION = "A host/service/network monitoring and management system core files"
HOMEPAGE = "http://www.nagios.org"
SECTION = "console/network"
PRIORITY = "optional"
LICENSE = "GPLv2"

LIC_FILES_CHKSUM = "file://LICENSE;md5=4c4203caac58013115c9ca4b85f296ae"

SRCNAME = "nagios"

SRC_URI = "http://prdownloads.sourceforge.net/sourceforge/${SRCNAME}/${SRCNAME}-${PV}.tar.gz \
           file://eventhandlers_nagioscmd_path.patch \
           file://volatiles \
           file://nagios-core.service \
           file://nagios-core-systemd-volatile.conf \
"

SRC_URI[md5sum] = "4bba4eef427cfb113fb513b6166a6af6"
SRC_URI[sha256sum] = "8b268d250c97851775abe162f46f64724f95f367d752ae4630280cc5d368ca4b"

S = "${WORKDIR}/${SRCNAME}-${PV}"

inherit autotools-brokensep update-rc.d systemd

DEPENDS = "gd"

RDEPENDS_${PN} += "\
    gd \
    libpng \
    fontconfig \
    apache2 \
    php \
    nagios-base \
"

# Set default password for the hardcoded Nagios admin user "nagiosadmin".
# If this variable is empty then will prompt user for password.
NAGIOS_DEFAULT_ADMINUSER_PASSWORD ??= "password"
NAGIOS_CGIBIN_DIR = "${libdir}/nagios/cgi-bin"

EXTRA_OECONF += "--sbindir=${NAGIOS_CGIBIN_DIR} \
                 --datadir=${datadir}/nagios/htdocs \
                 --with-command-group=nagcmd \
                 --with-httpd-conf=${sysconfdir}/apache2/conf.d \
                 --with-lockfile=${localstatedir}/run/nagios/nagios.pid \
                 --with-init-dir=${sysconfdir}/init.d \
"

# Prevent nagios from stripping binaries, bitbake will take care of that
EXTRA_OECONF += "ac_cv_path_STRIP=true"

# Prevent nagios from using dynamic libtool library
EXTRA_OECONF += "ac_cv_header_ltdl_h=no"

# Prevent nagios from suffering host contamination if host has /bin/perl
EXTRA_OECONF += "ac_cv_path_PERL=${bindir}/perl"

# Set to "1" to allow nagios-core post-init to modify Apache configuration
NAGIOS_MODIFY_APACHE ??= "1"

do_configure() {
    sed -e '/# Load any extra environment/i test -e `dirname $NagiosRunFile` || mkdir -p `dirname $NagiosRunFile`' \
        -e '/status)/{n;s/.*/\t\t[ -f $NagiosRunFile ] \&\& NagiosPID=`head -n 1 $NagiosRunFile`/}' \
        -i ${S}/daemon-init.in
    oe_runconf || die "make failed"
}

do_compile() {
    oe_runmake all
}

do_install() {
    oe_runmake 'DESTDIR=${D}' install
    oe_runmake 'DESTDIR=${D}' install-init
    oe_runmake 'DESTDIR=${D}' install-config
    oe_runmake 'DESTDIR=${D}' install-commandmode

    install -d ${D}${sysconfdir}/apache2/conf.d
    oe_runmake 'DESTDIR=${D}' install-webconf

    install -d ${D}${NAGIOS_PLUGIN_CONF_DIR}

    # There is no install target for the contributed eventhandlers so we
    # just do it.
    install -d ${D}${NAGIOS_PLUGIN_DIR}/eventhandlers
    for f in ${S}/contrib/eventhandlers/* ; do
        if ! [ -f $f ] ; then
            continue;
        fi
        install $f ${D}${NAGIOS_PLUGIN_DIR}/eventhandlers/
    done

    echo "cfg_dir=${NAGIOS_PLUGIN_CONF_DIR}" >> ${D}${NAGIOS_CONF_DIR}/nagios.cfg

    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -m 755 ${D}${sysconfdir}/init.d/nagios ${D}${sysconfdir}/nagios/nagios-core-startup.sh
        install -d ${D}${systemd_unitdir}/system
        install -m 644 ${WORKDIR}/nagios-core.service ${D}${systemd_unitdir}/system/
        install -d ${D}${sysconfdir}/tmpfiles.d
        install -m 755 ${WORKDIR}/nagios-core-systemd-volatile.conf ${D}${sysconfdir}/tmpfiles.d/nagios-core-volatile.conf
    else
        install -d ${D}${sysconfdir}/default/volatiles
        install -m 0644 ${WORKDIR}/volatiles ${D}${sysconfdir}/default/volatiles/99_nagios
    fi
}

pkg_postinst_ontarget_${PN}-setup () {
    # Set password for nagiosadmin user
    if [ -z "${NAGIOS_DEFAULT_ADMINUSER_PASSWORD}" ]; then
        htpasswd -c ${NAGIOS_CONF_DIR}/htpasswd.users nagiosadmin
    else
        htpasswd -b -c ${NAGIOS_CONF_DIR}/htpasswd.users nagiosadmin \
           "${NAGIOS_DEFAULT_ADMINUSER_PASSWORD}"
    fi

    # Apache2 might by default turn off CGI
    if [ "${NAGIOS_MODIFY_APACHE}" == "1" ] && [ -f "${sysconfdir}/apache2/httpd.conf" ]; then
        sed -e 's/^#LoadModule cgid_module/LoadModule cgid_module/g' -i ${sysconfdir}/apache2/httpd.conf
    fi
}

PACKAGES += "${SRCNAME}-base ${PN}-setup"

FILES_${PN} += "${datadir} \
                ${NAGIOS_PLUGIN_DIR} \
                ${NAGIOS_CGIBIN_DIR} \
"

FILES_${PN}-dbg += "${NAGIOS_CGIBIN_DIR}/.debug"

ALLOW_EMPTY_${SRCNAME}-base = "1"
ALLOW_EMPTY_${PN}-setup = "1"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "nagios-core.service"
SYSTEMD_AUTO_ENABLE_${PN} = "enable"

USERADD_PACKAGES += "${SRCNAME}-base"
GROUPADD_PARAM_${SRCNAME}-base = "-r ${NAGIOS_GROUP}"
USERADD_PARAM_${SRCNAME}-base = "-r -M -g ${NAGIOS_GROUP} ${NAGIOS_USER}"

INITSCRIPT_NAME = "nagios"
INITSCRIPT_PARAMS = "defaults"
