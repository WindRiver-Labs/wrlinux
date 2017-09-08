#
# Copyright (C) 2012, 2014 Wind River Systems, Inc.
#
SUMMARY = "An implementation of key management system for IPsec"

DESCRIPTION = "The Racoon2 project is a joint effort which provides an \
implementation of key management system for IPsec. The implementation is \
called Racoon2, a successor of Racoon, which was developed by the KAME \
project. It supports IKEv1, IKEv2, and KINK protocols. It works on \
FreeBSD, NetBSD, Linux, and Mac OS X."

HOMEPAGE = "http://ftp.racoon2.wide.ad.jp/pub/racoon2/"

DEPENDS = "${@bb.utils.contains('DISTRO_FEATURES', 'krb5', 'krb5', '', d)} libpcap openssl bison flex-native util-linux"
RDEPENDS_${PN} += "perl"

LICENSE = "BSD-3-Clause"

LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=99a60756441098855c538fe86f859afe"


SRC_URI = "http://ftp.racoon2.wide.ad.jp/pub/${PN}/${BPN}-${PV}.tgz \
           file://racoon2-configure-memcmp.patch \
           file://racoon2-correct-openssl-include-path.patch \
           file://racoon2-DESTDIR.patch \
           file://racoon2-disable-hard-limit-timer.patch \
           file://racoon2-fix-rekeying-reply.patch \
           file://racoon2-fix-sadb_msg_seq-collision.patch \
           file://racoon2-fix-target-perl-path-to-generate-RPM.patch \
           file://racoon2-wr-fwrite-return-value.patch \
           file://racoon2-fix-configure-error.patch \
           file://racoon2-Add-Value-to-HAVE_NSSWITCH_CONF.patch \
           file://racoon2-Remove-INSTALL_OPTS.patch \
           file://racoon2-iked-needs-libcrypto.patch \
           file://racoon2-removed-conflicting-prototypes.patch \
           file://racoon2_iked.patch \
           file://racoon2_kinkd.patch \
           file://racoon2_spmd.patch \
           file://racoon2-remove-deprecated-do-clause.patch \
           file://racoon2-configure.in-remove-redundant-macros.patch \
           file://volatiles.99_racoon2 \
           file://racoon2-configure-autoheader.patch \
           file://iked.service \
           file://spmd.service \
           file://reenable-the-ipv6-check.patch \
"

SRC_URI[md5sum] = "2fa33abff1ccd6fc22876a23db77aaa8"
SRC_URI[sha256sum] = "f23773e4d97cec823ec634085b5e60a7884a13467ff1bffc17daac14d02f9caa"

inherit autotools-brokensep update-rc.d systemd

FILES_${PN}-doc += "${mandir}/man8/spmdctl.8 \
                    ${mandir}/man/man8/pskgen.8 \
                    ${@bb.utils.contains('DISTRO_FEATURES', 'krb5', '${mandir}/man8/kinkd.8', '', d)} \
                    ${mandir}/man/man8/spmd.8 \
                    ${mandir}/man8/iked.8"                                                                 
FILES_${PN} += "${systemd_unitdir}"

EXTRA_OECONF += "--prefix="" \
                --exec-prefix="/usr" --sysconfdir="/etc/${BPN}" \
                --mandir=${mandir} --disable-pedant \
                --enable-pcap=yes \
                --enable-iked=yes \
                ${@bb.utils.contains('DISTRO_FEATURES', 'krb5', '--enable-kinkd', '--disable-kinkd', d)} \
                ${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', '--enable-ipv6', '--disable-ipv6', d)} \
                --with-openssl-libdir=${STAGING_DIR_TARGET} \
                --with-kernel-build-dir=${STAGING_INCDIR}"

do_install_append () {
    install -d -m 0755 ${D}${sysconfdir}/init.d/
    cp -rfa ${D}${sysconfdir}/${BPN}/init.d/* ${D}${sysconfdir}/init.d/

    rmdir ${D}${localstatedir}/run/racoon2 ${D}${localstatedir}/run ${D}${localstatedir}
    install -d ${D}${sysconfdir}/default/volatiles
    install -m 0700 ${WORKDIR}/volatiles.99_racoon2 ${D}${sysconfdir}/default/volatiles/99_racoon2
    if ${@bb.utils.contains('DISTRO_FEATURES', 'krb5', 'false', 'true', d)}; then
        rm -f ${D}${sysconfdir}/init.d/kinkd ${D}${sysconfdir}/${BPN}/init.d/kinkd \
        ${D}${sysconfdir}/${BPN}/transport_kink.conf.sample ${D}${sysconfdir}/${BPN}/tunnel_kink.conf.sample
    fi

    # Install systemd service files
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/iked.service ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/spmd.service ${D}${systemd_unitdir}/system
    sed -i -e 's#@SBINDIR@#${sbindir}#g' -e 's,@BASE_BINDIR@,${base_bindir},g' \
	 ${D}${systemd_unitdir}/system/*.service

    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -d ${D}${sysconfdir}/tmpfiles.d
        echo "d /var/run/racoon2 0700 root root -" \
        > ${D}${sysconfdir}/tmpfiles.d/${BPN}.conf
    fi
}

INITSCRIPT_PACKAGES = "${PN} ${PN}-iked ${PN}-${@bb.utils.contains('DISTRO_FEATURES', 'krb5', 'kinkd', '', d)}"
INITSCRIPT_NAME_${PN} = "spmd"
INITSCRIPT_PARAMS_${PN} = "remove"
INITSCRIPT_NAME_${PN}-iked = "iked"
INITSCRIPT_PARAMS_${PN}-iked = "remove"
INITSCRIPT_NAME_${PN}-kinkd = "kinkd"
INITSCRIPT_PARAMS_${PN}-kinkd= "remove"


SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "spmd.service iked.service"
SYSTEMD_AUTO_ENABLE = "disable"

# This is only needed when we install/update on a running target.
#
pkg_postinst_${PN} () {
	if [ -z "$D" ]; then
		if [ -e ${sysconfdir}/init.d/populate-volatile.sh ]; then
			${sysconfdir}/init.d/populate-volatile.sh update
		fi
	fi
}


