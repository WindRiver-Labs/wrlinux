#
# Copyright (C) 2012-2014, 2019 Wind River Systems, Inc.
#

RDEPENDS_${PN} += "policycoreutils"

FILESEXTRAPATHS_prepend := "${THISDIR}/refpolicy-wr:"

SRC_URI += "\
        file://0001-policy-modules-system-userdomain-allow-secadm-to-rea.patch \
        file://0002-policy-modules-system-selinuxutil-allow-secadm-to-ma.patch \
        file://0003-policy-modules-app-crash-add-crash-policy-module.patch \
        file://0004-policy-modules-admin-newgrp-add-newgrp-policy-module.patch \
        file://0005-policy-modules-system-systemd-set-correct-context-fo.patch \
        file://0006-policy-modules-system-sysnetwork-allow-systemd_netwo.patch \
        file://0007-policy-modules-system-ipsec-fix-strongswan-startup-f.patch \
        file://0008-policy-modules-services-radius-fix-freeradius-startu.patch \
        file://0009-policy-modules-services-radius-allow-radius_t-to-bin.patch \
        file://0010-policy-modules-services-ntp-allow-ntpd-to-set-rlimit.patch \
        file://0011-policy-modules-services-samba-fix-avc-denials-for-sa.patch \
        file://0012-policy-modules-services-postfix.te-allow-postfix_loc.patch \
        file://0013-policy-modules-services-mta-allow-user_mail_t-to-man.patch \
        file://0014-policy-modules-admin-logwatch-fix-avc-denials-for-lo.patch \
        file://0015-policy-modules-services-zebra-allow-zebra_t-to-read-.patch \
        file://0016-policy-modules-system-ipsec-make-ipsec-domain-MLS-tr.patch \
        file://0017-policy-modules-admin-logwatch-make-logwatch_mail_t-d.patch \
        file://0018-policy-modules-services-postfix-make-postfix-domain-.patch \
        file://0019-policy-modules-services-sendmail-make-sendmail_t-dom.patch \
        file://0020-policy-modules-services-snmp-make-snmpd_t-domain-MLS.patch \
        file://0021-policy-modules-services-zebra-make-zebra_t-domain-ML.patch \
        file://0022-policy-modules-services-ftp-fix-avc-denials-for-ftpd.patch \
        file://0023-policy-modules-services-mta-make-system_mail_t-domai.patch \
        file://0024-policy-modules-admin-su-fix-su-failure-for-non-root-.patch \
        file://0025-policy-modules-services-watchdog-allow-watchdog_t-to.patch \
        file://0026-policy-modules-system-mount-allow-mount_t-to-getattr.patch \
        file://0027-policy-modules-services-bind-add-getsched-and-setsch.patch \
        file://0028-policy-modules-services-postfix-allow-postfix_postdr.patch \
        file://0029-Revert-kernel-Drop-unlabeled_t-as-a-files_mountpoint.patch \
        file://0030-policy-modules-roles-sysadm-allow-sysadm_t-to-read-f.patch \
        "

OSTREE_POLICY_PATCHES = "\
        file://wr-policy-file_contexts.subs_dist-fix-label-for-usr-etc.patch \
        file://wr-policy-files-add-lable-if-mnt-opt-media-is-symlinks-file.patch \
        file://wr-policy-system-mount.te-allow-mount-on-symlink-file.patch \
        file://wr-policy-system-locallogin.te-allow-login-read-symlink-file.patch \
        file://wr-policy-allow-mount-to-dirs-under-tmp.patch \
        file://wr-policy-Add-ostree-policy.patch \
        file://wr-policy-Allow-sshd_t-and-staff_t-read-symlinks.patch \
        file://wr-policy-lable-system-export-as-ostree_exec_t.patch \
        file://wr-policy-file_contexts.subs_dist-set-aliases-for-var-home-and.patch \
        file://wr-policy-modules-system-mount-allow-mount-command-to-m.patch \
        file://wr-policy-modules-system-systemd-allow-systemd_generato.patch \
        file://wr-policy-modules-system-userdomain-allow-domain-read-h.patch \
        file://wr-policy-modules-system-systemd-allow-systemd_tmpfiles.patch \
        file://wr-policy-modules-admin-ostree-fix-ostree-unlock.patch \
        "

SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'ostree', '${OSTREE_POLICY_PATCHES}', '', d)}"
