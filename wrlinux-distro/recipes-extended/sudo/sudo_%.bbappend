#
# Copyright (C) 2014, 2017 Wind River Systems, Inc.
#
# Enable group wheel in sudoers by default
#

PACKAGECONFIG[pam-wheel] = ",,,pam-plugin-wheel"

do_install_append () {
    if ${@bb.utils.contains('PACKAGECONFIG', 'pam-wheel', 'true', 'false', d)} ; then
        echo 'auth       required     pam_wheel.so use_uid' >>${D}${sysconfdir}/pam.d/sudo
        sed -i 's/# \(%wheel ALL=(ALL) ALL\)/\1/' ${D}${sysconfdir}/sudoers
    fi
}
