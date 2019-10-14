#
# Copyright (C) 2014, 2016, 2017, Wind River Systems, Inc.
#
# Note that support for pam_console and pam_chroot from Fedora,
# which used to be here, is now added by a bbappend under wrlinux.

SRC_URI += "${@bb.utils.contains('PACKAGECONFIG', 'tally2', '\
	file://pam_tally2_add_uid.patch \
	file://pam_tally2_faillog.patch', '', d)} \
"

FILESEXTRAPATHS_prepend := "${THISDIR}/libpam:"

PACKAGECONFIG[tally2] = ",,,"

RDEPENDS_${PN}-runtime += "${@bb.utils.contains('PACKAGECONFIG', 'tally2', 'pam-plugin-tally2', '', d)}"

do_install_append() {
    if ${@bb.utils.contains('PACKAGECONFIG', 'tally2', 'true', 'false', d)}; then
        sed -i '/end of pam-auth-update config/i \
            # tally2 is required to reset the fail count on success\
            account    required            pam_tally2.so' \
            ${D}${sysconfdir}/pam.d/common-account
        sed -i '/pam_unix.so/i \
            auth   required            pam_tally2.so deny=5 lock_time=6 even_deny_root root_unlock_time=60' \
            ${D}${sysconfdir}/pam.d/common-auth
    fi
}
