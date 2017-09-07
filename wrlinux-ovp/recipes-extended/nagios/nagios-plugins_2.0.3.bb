require nagios-common.inc

DESCRIPTION = "A host/service/network monitoring and management system plugins"
HOMEPAGE = "http://www.nagios-plugins.org"
SECTION = "console/network"
PRIORITY = "optional"
LICENSE = "GPLv3"

LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"

SRC_URI = "https://www.nagios-plugins.org/download/${BPN}-${PV}.tar.gz \
"

SRC_URI[md5sum] = "6755765bab88b506181268ef7982595e"
SRC_URI[sha256sum] = "8f0021442dce0138f0285ca22960b870662e28ae8973d49d439463588aada04a"

S = "${WORKDIR}/${BPN}-${PV}"

inherit autotools gettext

EXTRA_OECONF += "--with-sysroot=${STAGING_DIR_HOST} \
                 --with-nagios-user=${NAGIOS_USER} \
                 --with-nagios-group=${NAGIOS_GROUP} \
                 --without-apt-get-command \
                 --with-trusted-path=/bin:/sbin:/usr/bin:/usr/sbin \
                 ac_cv_path_PERL=${bindir}/perl \
"

# IPv6
PACKAGECONFIG[ipv6] = "--with-ipv6,--without-ipv6,,"

# Enable check_ldaps, check_http --ssl, check_tcp --ssl
PACKAGECONFIG[ssl] = "--with-openssl=${STAGING_DIR_HOST},--without-openssl,openssl,libssl"

# Enable check_ldaps
PACKAGECONFIG[ldap] = "--with-ldap,--without-ldap,openldap"

# Enable check_smtp --starttls
PACKAGECONFIG[gnutls] = "--with-gnutls=${STAGING_DIR_HOST},--without-gnutls,gnutls,gnutls"

# Enable check_pgsql
PACKAGECONFIG[pgsql] = "--with-pgsql=${STAGING_DIR_HOST},--without-pgsql,postgresql,libpq"

# Enable check_mysql, check_mysql_query
PACKAGECONFIG[mysql] = "--with-mysql=${STAGING_DIR_HOST},--without-mysql,mysql5,libmysqlclient"

# Enable check_snmp
PACKAGECONFIG[snmp] = "\
    --with-snmpget-command=${bindir}/snmpget --with-snmpgetnext-command=${bindir}/snmpgetnext, \
    --without-snmpget-command --without-snmpgetnext-command, \
    , net-snmp-utils \
"

PACKAGECONFIG ??= "ssl gnutls"

do_configure() {
    oe_runconf || die "make failed"
}

do_install_append() {
     sed -i '1s,#! /usr/bin/perl -w.*,#! ${bindir}/env perl,' ${D}${libdir}/nagios/plugins/*
}

RDEPENDS_${PN} += "\
    iputils \
    nagios-base \
    perl \
    bash \
"

FILES_${PN} += "${datadir} \
                ${NAGIOS_PLUGIN_DIR} \
"
