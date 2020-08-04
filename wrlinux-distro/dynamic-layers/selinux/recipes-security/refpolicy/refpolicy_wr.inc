#
# Copyright (C) 2012-2014, 2019 Wind River Systems, Inc.
#

RDEPENDS_${PN} += "policycoreutils"

FILESEXTRAPATHS_prepend := "${THISDIR}/refpolicy-wr:"

SRC_URI += "\
        file://0001-policy-modules-system-userdomain-allow-secadm-to-rea.patch \
        file://0002-policy-modules-system-sysnetwork-make-dhcpc_t-domain.patch \
        file://0003-policy-modules-services-inetd-make-inetd_t-domain-ML.patch \
        file://0004-policy-modules-services-inetd-make-ipsec-domain-MLS-.patch \
        file://0005-policy-modules-services-bind-make-named_t-domain-MLS.patch \
        file://0006-policy-modules-services-postfix-make-postfix-domain-.patch \
        file://0007-policy-modules-services-snmp-make-snmpd_t-domain-MLS.patch \
        file://0008-policy-modules-services-zebra-make-zebra_t-domain-ML.patch \
        file://0009-policy-modules-services-radius-fix-avc-denials-for-f.patch \
        file://0010-policy-modules-services-radius-allow-radius_t-to-bin.patch \
        file://0011-policy-modules-services-sendmail-make-sendmail_t-dom.patch \
        file://0012-policy-modules-services-cron-allow-crond_t-to-search.patch \
        file://0013-policy-modules-services-ftp-fix-avc-denials-for-ftpd.patch \
        file://0014-policy-modules-services-samba-fix-avc-denials-for-sa.patch \
        file://0015-policy-modules-admin-logwatch-fix-avc-denials-for-lo.patch \
        file://0016-policy-modules-system-systemd-set-correct-context-fo.patch \
        file://0017-policy-modules-system-systemd-allow-systemd_logind_t.patch \
        file://0018-policy-modules-system-sysnetwork-allow-systemd_netwo.patch \
        file://0019-policy-modules-services-ntp-allow-ntpd-to-set-rlimit.patch \
        file://0020-policy-modules-system-logging-set-label-devlog_t-to-.patch \
        file://0021-policy-modules-system-systemd-fix-avc-denials-for-sy.patch \
        file://0022-policy-modules-system-systemd-fix-avc-denials-for-sy.patch \
        file://0023-policy-modules-system-userdomain-add-userdom_transit.patch \
        file://0024-policy-modules-system-init-fix-error-for-spawning-li.patch \
        file://0025-policy-modules-roles-sysadm-fix-avc-denials-for-sysa.patch \
        file://0026-policy-modules-system-logging-allow-syslogd_t-to-lis.patch \
        file://0027-policy-modules-services-crontab-allow-sysadm_r-to-ru.patch \
        file://0028-policy-modules-app-crash-add-crash-policy-module.patch \
        file://0029-policy-modules-services-acpi-make-acpid_t-domain-MLS.patch \
        file://0030-policy-modules-services-bluetooth-make-bluetooth_t-d.patch \
        file://0031-policy-modules-services-mta-make-system_mail_t-domai.patch \
        file://0032-policy-modules-system-systemd-make-systemd_hostnamed.patch \
        file://0033-policy-modules-system-systemd-make-systemd_rfkill_t-.patch \
        file://0034-policy-modules-system-systemd-make-systemd_generator.patch \
        file://0035-policy-modules-kernel-domain-allow-domain-to-map-gen.patch \
        file://0036-policy-modules-services-mta-allow-user_mail_t-to-man.patch \
        file://0037-policy-modules-admin-su-fix-su-failure-for-non-root-.patch \
        file://0038-policy-modules-system-selinuxutil-allow-secadm-to-ma.patch \
        file://0039-policy-modules-admin-newgrp-add-newgrp-policy-module.patch \
        file://0040-policy-modules-services-watchdog-allow-watchdog_t-to.patch \
        file://0041-policy-modules-system-mount-allow-mount_t-to-getattr.patch \
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
        "

SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'ostree', '${OSTREE_POLICY_PATCHES}', '', d)}"
