#
# Copyright (C) 2014, 2016, 2017, Wind River Systems, Inc.
#
# Note that support for pam_console and pam_chroot from Fedora,
# which used to be here, is now added by a bbappend under wrlinux.

SRC_URI += "${@bb.utils.contains('PACKAGECONFIG', 'faillock', '\
	file://pam_faillock_add_uid.patch \
	file://0001-faillock-create-dir-before-create-tally-file.patch', '', d)} \
"

FILESEXTRAPATHS_prepend := "${THISDIR}/libpam:"

PACKAGECONFIG[faillock] = ",,,"

RDEPENDS_${PN}-runtime += "${@bb.utils.contains('PACKAGECONFIG', 'faillock', 'pam-plugin-faillock', '', d)}"

do_install_append() {
    if ${@bb.utils.contains('PACKAGECONFIG', 'faillock', 'true', 'false', d)}; then
        sed -i '/end of pam-auth-update config/i \
            # faillock is required to reset the fail count on success\
account    required            pam_faillock.so' \
            ${D}${sysconfdir}/pam.d/common-account
        sed -i '/pam_unix.so/i \
auth   required   pam_faillock.so preauth  deny=5  even_deny_root root_unlock_time=60 unlock_time=0 \
auth   required   pam_faillock.so authfail deny=5 even_deny_root  root_unlock_time=60 unlock_time=0' \
            ${D}${sysconfdir}/pam.d/common-auth
    fi
}
