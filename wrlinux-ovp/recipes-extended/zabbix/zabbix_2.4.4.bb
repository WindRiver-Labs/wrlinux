SUMMARY = "Zabbix Monitoring System"
DESCRIPTION = "\
Zabbix is the ultimate enterprise-level software \
designed for monitoring availability and performance \
of IT infrastructure components \
"

HOMEPAGE = "http://www.zabbix.com/"
SECTION = "console/network"
PRIORITY = "optional"
LICENSE = "GPLv2"

LIC_FILES_CHKSUM = "file://COPYING;md5=300e938ad303147fede2294ed78fe02e"

SRCNAME = "zabbix"

SRC_URI = "http://sourceforge.net/projects/zabbix/files/ZABBIX%20Latest%20Stable/${PV}/zabbix-${PV}.tar.gz \
           file://use-pkg-config-to-extract-postgresql.patch \
           file://zabbix-force-using-PKG_CONFIG-to-get-postgresql-sett.patch \           
           file://zabbix-server-pgsql.service \
           file://zabbix-proxy-pgsql.service \
           file://zabbix-agentd.service \
           file://zabbix_server_pgsql_setup.sh \
           file://zabbix_proxy_pgsql_setup.sh \
           file://zabbix_agentd_config.sh \
           file://zabbix_proxy_config.sh \
           file://zabbix-apache2.conf \
           file://zabbix-volatile.conf \
           file://zabbix.conf.php \
"

SRC_URI[md5sum] = "400a3e2ebec80e2f1fe86d1b32bfd2e1"
SRC_URI[sha256sum] = "e9f31b96104681b050fd27b4a669736dea9c5d4efc8444effb2bff1eab6cc34c"

S = "${WORKDIR}/${SRCNAME}-${PV}"

inherit autotools-brokensep useradd systemd logging monitoring-hosts pkgconfig

DEPENDS = "postgresql"

EXTRA_OECONF += "--enable-server \
                 --enable-proxy \
                 --enable-agent \
                 --with-postgresql \
"

ZABBIX_USERID ??= "zabbix"
ZABBIX_GROUPID ??= "zabbix"

# Set to "1" to allow zabbix post-init to modify PHP configuration
ZABBIX_MODIFY_PHP ??= "1"

ZABBIX_FRONTEND_PHP_DIR ??= "${datadir}/zabbix/frontends/php"

ZABBIX_SERVER_DBNAME ??= "zabbix"
ZABBIX_SERVER_DBUSER = "${ZABBIX_USERID}"
ZABBIX_SERVER_DBPASSWORD ??= "zabbix"

ZABBIX_PROXY_DBNAME ??= "zabbix_proxy"
ZABBIX_PROXY_DBUSER = "${ZABBIX_USERID}"
ZABBIX_PROXY_DBPASSWORD ??= "zabbix"

ZABBIX_APACHE2_PHP_POST_MAX_SIZE ??= "16M"
ZABBIX_APACHE2_PHP_MAX_EXECUTION_TIME ??= "300"
ZABBIX_APACHE2_PHP_MAX_INPUT_TIME ??= "300"
ZABBIX_APACHE2_PHP_TIMEZONE ??= "Universal"

PACKAGES =+ "\
    ${SRCNAME}-frontend-php \
    ${SRCNAME}-agent \
    ${SRCNAME}-proxy-pgsql \
    ${SRCNAME}-server-pgsql \
    ${SRCNAME}-pgsql-setup \
"

RDEPENDS_${SRCNAME}-pgsql-setup = "postgresql postgresql-client"
RDEPENDS_${SRCNAME}-frontend-php = "${PN} php bash"
RDEPENDS_${SRCNAME}-proxy-pgsql = "${PN} ${SRCNAME}-pgsql-setup bash"
RDEPENDS_${SRCNAME}-server-pgsql = "${PN} ${SRCNAME}-pgsql-setup bash"
RDEPENDS_${SRCNAME}-agent = "${PN} bash"

USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM_${PN} = "-r ${ZABBIX_GROUPID}"
USERADD_PARAM_${PN} = "-r -M -g ${ZABBIX_GROUPID} ${ZABBIX_USERID}"

FILES_${SRCNAME}-frontend-php = "\
    ${datadir}/zabbix/frontends \
    ${sysconfdir}/apache2 \
"

FILES_${SRCNAME}-agent = "\
    ${sbindir}/zabbix_agent \
    ${sbindir}/zabbix_agentd \
    ${bindir}/zabbix_sender \
    ${sysconfdir}/zabbix/zabbix_agent.conf \
    ${sysconfdir}/zabbix/zabbix_agent.conf.d \
    ${sysconfdir}/zabbix/zabbix_agentd.conf \
    ${sysconfdir}/zabbix/zabbix_agentd.conf.d \
    ${sysconfdir}/zabbix/zabbix_agentd_config.sh \
"

FILES_${SRCNAME}-proxy-pgsql = "\
    ${sbindir}/zabbix_proxy \
    ${sysconfdir}/zabbix/zabbix_proxy.conf \
    ${sysconfdir}/zabbix/zabbix_proxy.conf.d \
    ${sysconfdir}/zabbix/database/postgresql/zabbix_proxy_pgsql_setup.sh \
    ${sysconfdir}/zabbix/zabbix_proxy_config.sh \
"

FILES_${SRCNAME}-server-pgsql = "\
    ${sbindir}/zabbix_server \
    ${bindir}/zabbix_get \
    ${datadir}/zabbix \
    ${sysconfdir}/zabbix/zabbix_server.conf \
    ${sysconfdir}/zabbix/zabbix_server.conf.d \
    ${sysconfdir}/zabbix/database/postgresql/zabbix_server_pgsql_setup.sh \
"

FILES_${PN} = "\
    ${libdir} \
    ${sysconfdir}/tmpfiles.d/ \
"

FILES_${SRCNAME}-pgsql-setup ="\
    ${sysconfdir}/zabbix/database/ \
"

ZABBIX_SERVER_SERVICE_NAME ??= "${SRCNAME}-server-pgsql.service"
ZABBIX_PROXY_SERVICE_NAME ??= "${SRCNAME}-proxy-pgsql.service"
ZABBIX_AGENTD_SERVICE_NAME ??= "${SRCNAME}-agentd.service"

SYSTEMD_PACKAGES = "\
    ${SRCNAME}-agent \
    ${SRCNAME}-proxy-pgsql \
    ${SRCNAME}-server-pgsql \
"
SYSTEMD_SERVICE_${SRCNAME}-server-pgsql = "${ZABBIX_SERVER_SERVICE_NAME}"
SYSTEMD_AUTO_ENABLE_${SRCNAME}-server-pgsql = "enable"
SYSTEMD_SERVICE_${SRCNAME}-proxy-pgsql = "${ZABBIX_PROXY_SERVICE_NAME}"
SYSTEMD_AUTO_ENABLE_${SRCNAME}-proxy-pgsql = "enable"
SYSTEMD_SERVICE_${SRCNAME}-agent = "${ZABBIX_AGENTD_SERVICE_NAME}"
SYSTEMD_AUTO_ENABLE_${SRCNAME}-agent = "enable"

do_configure() {
    oe_runconf || die "make failed"
}

do_install_append() {
    install -d ${D}${ZABBIX_FRONTEND_PHP_DIR}/
    cp -rf ${S}/frontends/php/* ${D}${ZABBIX_FRONTEND_PHP_DIR}/
    install -m 755 ${WORKDIR}/zabbix.conf.php ${D}${ZABBIX_FRONTEND_PHP_DIR}/conf/
    install -d ${D}${sysconfdir}/zabbix/database/postgresql
    install -m 755 ${WORKDIR}/zabbix_server_pgsql_setup.sh ${D}${sysconfdir}/zabbix/database/postgresql/
    install -m 755 ${WORKDIR}/zabbix_proxy_pgsql_setup.sh ${D}${sysconfdir}/zabbix/database/postgresql/
    install -m 755 ${WORKDIR}/zabbix_agentd_config.sh ${D}${sysconfdir}/zabbix/
    install -m 755 ${WORKDIR}/zabbix_proxy_config.sh ${D}${sysconfdir}/zabbix/
    install -m 755 ${S}/database/postgresql/* ${D}${sysconfdir}/zabbix/database/postgresql/
    mv ${D}${sysconfdir}/zabbix*conf* ${D}${sysconfdir}/zabbix/
    install -d ${D}${sysconfdir}/apache2/conf.d
    install -m 755 ${WORKDIR}/zabbix-apache2.conf ${D}${sysconfdir}/apache2/conf.d/zabbix.conf

    sed -e "s:%ZABBIX_SERVER_DBNAME%:${ZABBIX_SERVER_DBNAME}:g" \
        -e "s:%ZABBIX_SERVER_DBUSER%:${ZABBIX_SERVER_DBUSER}:g" \
        -e "s:%ZABBIX_SERVER_DBPASSWORD%:${ZABBIX_SERVER_DBPASSWORD}:g" \
        -i ${D}${ZABBIX_FRONTEND_PHP_DIR}/conf/zabbix.conf.php

    sed -e "s:%ZABBIX_SERVER_DBNAME%:${ZABBIX_SERVER_DBNAME}:g" \
        -e "s:%ZABBIX_SERVER_DBUSER%:${ZABBIX_SERVER_DBUSER}:g" \
        -e "s:%ZABBIX_SERVER_DBPASSWORD%:${ZABBIX_SERVER_DBPASSWORD}:g" \
        -i ${D}${sysconfdir}/zabbix/database/postgresql/zabbix_server_pgsql_setup.sh

    sed -e "s:%ZABBIX_PROXY_DBNAME%:${ZABBIX_PROXY_DBNAME}:g" \
        -e "s:%ZABBIX_PROXY_DBUSER%:${ZABBIX_PROXY_DBUSER}:g" \
        -e "s:%ZABBIX_PROXY_DBPASSWORD%:${ZABBIX_PROXY_DBPASSWORD}:g" \
        -i ${D}${sysconfdir}/zabbix/database/postgresql/zabbix_proxy_pgsql_setup.sh

    sed -e "s:%ZABBIX_AGENTD_CONF%:${sysconfdir}/zabbix/zabbix_agentd.conf:g" \
        -e "s:%ZABBIX_AGENTD_SYSTEMD_NAME%:${ZABBIX_AGENTD_SERVICE_NAME}:g" \
        -i ${D}${sysconfdir}/zabbix/zabbix_agentd_config.sh

    sed -e "s:%ZABBIX_PROXY_CONF%:${sysconfdir}/zabbix/zabbix_proxy.conf:g" \
        -e "s:%ZABBIX_PROXY_SYSTEMD_NAME%:${ZABBIX_PROXY_SERVICE_NAME}:g" \
        -i ${D}${sysconfdir}/zabbix/zabbix_proxy_config.sh

    sed -e "s:^LogFile=/tmp/zabbix_agentd.log:LogFile=/var/log/zabbix/zabbix_agentd.log:g" \
        -e "/^# Include=$/a Include=\/etc\/zabbix/zabbix_agentd.conf.d\/" \
        -e "/^# PidFile=.*/a PidFile=\/var\/run\/zabbix\/zabbix_agentd.pid" \
        -e "s:^Server=.*:Server=${MONITORING_AGENT_SERVER_IP}:g" \
        -e "s:^ServerActive=.*:ServerActive=${MONITORING_AGENT_SERVER_IP}:g" \
        -e "s:^Hostname=.*:Hostname=${MONITORING_AGENT_NAME}:g" \
        -i ${D}${sysconfdir}/zabbix/zabbix_agentd.conf

    sed -e "s:^LogFile=/tmp/zabbix_proxy.log:LogFile=/var/log/zabbix/zabbix_proxy.log:g" \
        -e "s:^DBName=.*:DBName=${ZABBIX_PROXY_DBNAME}:g" \
        -e "s:^DBUser=.*:DBUser=${ZABBIX_PROXY_DBUSER}:g" \
        -e "s:^# DBPassword=:DBPassword=${ZABBIX_PROXY_DBPASSWORD}:g" \
        -e "/^# Include=$/a Include=\/etc\/zabbix/zabbix_proxy.conf.d\/" \
        -e "/^# PidFile=.*/a PidFile=\/var\/run\/zabbix\/zabbix_proxy_pgsql.pid" \
        -e "s:^Server=.*:Server=${MONITORING_PROXY_SERVER_IP}:g" \
        -e "s:^Hostname=.*:Hostname=${MONITORING_PROXY_NAME}:g" \
        -i ${D}${sysconfdir}/zabbix/zabbix_proxy.conf

    sed -e "s:^LogFile=/tmp/zabbix_server.log:LogFile=/var/log/zabbix/zabbix_server.log:g" \
        -e "s:^DBName=.*:DBName=${ZABBIX_SERVER_DBNAME}:g" \
        -e "s:^DBUser=.*:DBUser=${ZABBIX_SERVER_DBUSER}:g" \
        -e "s:^# DBPassword=:DBPassword=${ZABBIX_SERVER_DBPASSWORD}:g" \
        -e "/^# Include=$/a Include=\/etc\/zabbix/zabbix_server.conf.d\/" \
        -e "/^# PidFile=.*/a PidFile=\/var\/run\/zabbix\/zabbix_server_pgsql.pid" \
        -i ${D}${sysconfdir}/zabbix/zabbix_server.conf

    sed -e "s:%ZABBIX_FRONTEND_PHP_DIR%:${ZABBIX_FRONTEND_PHP_DIR}:g" \
        -i ${D}${sysconfdir}/apache2/conf.d/zabbix.conf

    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -d ${D}${systemd_unitdir}/system
        install -m 755 ${WORKDIR}/zabbix-server-pgsql.service ${D}${systemd_unitdir}/system/
        install -m 755 ${WORKDIR}/zabbix-proxy-pgsql.service ${D}${systemd_unitdir}/system/
        install -m 755 ${WORKDIR}/zabbix-agentd.service ${D}${systemd_unitdir}/system/

        install -d ${D}${sysconfdir}/tmpfiles.d
        install -m 755 ${WORKDIR}/zabbix-volatile.conf ${D}${sysconfdir}/tmpfiles.d/
    else
        bbwarn "sysvinit is not currently supported."
    fi
}

pkg_postinst_${SRCNAME}-frontend-php() {
    if [ "x$D" != "x" ]; then
        exit 1
    fi

    if [ "${ZABBIX_MODIFY_PHP}" == "1" ] && [ -f "${sysconfdir}/php/apache2-php5/php.ini" ]; then
        sed -e "s/^post_max_size = .*/post_max_size = ${ZABBIX_APACHE2_PHP_POST_MAX_SIZE}/g" \
            -e "s/^max_execution_time = .*/max_execution_time = ${ZABBIX_APACHE2_PHP_MAX_EXECUTION_TIME}/g" \
            -e "s/^max_input_time = .*/max_input_time = ${ZABBIX_APACHE2_PHP_MAX_INPUT_TIME}/g" \
            -e "s/^;date.timezone =/date.timezone = ${ZABBIX_APACHE2_PHP_TIMEZONE}/g" \
            -i ${sysconfdir}/php/apache2-php5/php.ini
    fi

    # ${ZABBIX_FRONTEND_PHP_DIR}/conf/zabbix.conf.php file is used by Apache2 processes to
    # access to Zabbix database.  This file contains plan password.  At least security,
    # make sure only Apache2 processes can read from this file.
    APACHE2_USER=`find /etc/apache2/ -name httpd.conf | xargs cat | sed 's:\t: :g' | grep '^[ ]*User' | awk '{print $2}'`
    chmod 750 ${ZABBIX_FRONTEND_PHP_DIR}/conf/zabbix.conf.php
    chown ${APACHE2_USER}:root ${ZABBIX_FRONTEND_PHP_DIR}/conf/zabbix.conf.php
}
