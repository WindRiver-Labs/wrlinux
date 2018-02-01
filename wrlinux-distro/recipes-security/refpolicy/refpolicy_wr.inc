#
# Copyright (C) 2012-14 Wind River Systems, Inc.
#

RDEPENDS_${PN} += "policycoreutils"

FILESEXTRAPATHS_prepend := "${THISDIR}/refpolicy-wr:"

# Other policy fixes
SRC_URI += "file://wr-policy-getty-console.patch \
            file://wr-policy-syslog-ng.patch \
            file://wr-policy-syslog-ng-allow-read-rand-urand-device.patch \
            file://wr-policy-kdump-bool-sysadm.patch \
            file://wr-policy-MLS-sysadm-rw-to-clearance.patch \
            file://wr-policy-virt-bool-unconfined-vm.patch \
            file://wr-policy-mount-allow-setsched-for-kernel_t-process.patch \
            file://wr-policy-mount-allow-override-context.patch \
            file://wr-policy-filesystem-associate-devpts_t-to-devtmpfs.patch \
            file://wr-policy-dmesg-allow-dmesg-read-dev-kmsg.patch \
            file://wr-policy-zebra-allow-zebra_t-manage-zebra_tmp_t-files.patch \
            file://wr-policy-postfix-allow-postfix-script-read-var.patch \
            file://wr-policy-ldap-allow-slapd-read-dev-random.patch \
            file://wr-policy-alsa-allow-alsactl-search-dev-snd.patch \
            file://wr-policy-remove-avc-denied-for-named-service.patch \
            file://wr-policy-samhain-fix-avc-denied.patch \
            file://wr-policy-samba-fix-avc-denied.patch \
            file://wr-policy-bind-dontaudit-mount-write-setattr.patch \
            file://wr-policy-selinuxutil-allow-run_init-exec-all-initscripts.patch \
            file://wr-policy-sysamd-allow-to-exec-kadmind.patch \
            file://wr-policy-dhcp-dontaudit-rw-to-dev-console-pts.patch \
            file://wr-policy-logging-allow-auditctl-read-tmp-lnk_file.patch \
            file://wr-policy-dontaudit-attempts-to-search-kernel-debugfs.patch \
            file://wr-fc-openldap.patch \
            file://wr-fc-krb5.patch \
            file://wr-fc-lvm2.patch \
            file://wr-fc-ntp.patch \
            file://wr-fc-cfengine.patch \
            file://wr-fc-udevadm.patch \
            file://wr-fc-brctl.patch \
            file://wr-fc-mta.patch \
            file://wr-fc-netutils.patch \
            file://wr-fc-ntop.patch \
            file://wr-fc-snmp.patch \
            file://wr-allow-ifconfig-to-read-search-var-run.patch \
            file://portmap-allow-portmap-to-create-socket.patch \
            file://wr-policy-drbd.patch \
            file://wr-policy-allow-sysadm-run-crontab.patch \
            file://wr-policy-kerberos.patch \
            file://wr-policy-selinuxutils.patch \
            file://wr-policy-modutils.patch \
            file://Give-ppp_on_boot-script-correct-file-context.patch \
            file://allow-setrans-to-access-sys-fs-selinux.patch \
            file://make-openais-be-able-to-work.patch \
            file://Give-resolv.conf-the-net_conf_t-security-label.patch \
            file://wr-policy-clock-allow-hwclock_t-create-adjtime_t.patch \
            file://refpolicy-mls-newgrp.patch \
            file://wr-policy-avahi-dontaudit-rw-console.patch \
            file://wr-policy-telnet-fix-for-telnetlogin.patch \
            file://wr-policy-fix-file_contexts.subs_dist.patch \
            file://wr-policy-fix-security_validate_transition.patch \
            file://wr-policy-init_t-get-all-service-status.patch \
            file://wr-policy-allow-init_t-read-any-level-sockets.patch \
            file://wr-policy-fix-avc-denials-from-systemd-logind.patch \
            file://wr-policy-fix-systemd-journal-failure.patch \
            file://wr-policy-fix-avc-denials-from-systemd-cgroups.patch \
            file://wr-policy-fix-avc-denials-from-systemd-tmpfile.patch \
            file://wr-policy-fix-avc-denials-from-watchdog.patch \
            file://wr-policy-allow-auditd-use-all-levels-fd.patch \
            file://wr-policy-fc-fstools.patch \
            file://wr-policy-allow-sysadm_t-connectto-init_t-socket.patch \
            file://wr-policy-allow-sysadm_t-start-stop-status-service.patch \
            file://wr-policy-fix-service-radiusd.patch \
            file://wr-policy-fix-avc-denials-about-searching-journal-dir.patch \
            file://wr-policy-fix-ssh-login-failure.patch \
            file://wr-policy-allow-daemon-write-to-socket-file.patch \
            file://wr-policy-allow-ftpd_t-auditd_t-write-to-socket-at-a.patch \
            file://wr-policy-allow-systemd_logind_t-manage-run-user.patch \
            file://wr-policy-fix-avc-denials-for-ipsec.patch \
            file://wr-policy-allow-systemd_logind_t-sys_admin-itself.patch \
            file://wr-policy-fix-avc-denials-while-running-newaliases.patch \
            file://wr-policy-fix-avc-denials-to-setrans_t.patch \
            file://wr-policy-allow-mount_t-getattr-of-all-filesystems.patch \
            file://wr-policy-allow-postfix_master_t-getsched-to-itself.patch \
            file://wr-policy-fix-avc-denials-to-systemd_logind_t.patch \
            file://wr-policy-allow-passwd_t-useradd_t-search-journal.patch \
            file://wr-policy-fix-avc-denial-while-sysvinit-rebooting.patch \
            file://wr-policy-allow-unconfined_domain_type-manage-system.patch \
            file://wr-policy-allow-radiusd_t-getcap-to-itself.patch \
            file://wr-policy-allow-initrc_t-start-systemd_unit_t-servic.patch \
            file://wr-policy-fix-su-failure-with-non-root-users.patch \
            file://wr-dontaudit-several-operations-of-useradd-newrole-and-.patch \
            file://mysql-allow-mysqld_safe-to-read-var-log.patch \
            file://wr-rpcbind-manage-tmpfiles.patch \
            file://wr-policy-fixes-for-type-_sudo_t.patch \
            file://wr-policy-dontaudit-use-privfd.patch \
            file://wr-policy-dontaudit-passwd-rw-to-run-utmp.patch \
            file://wr-policy-allow-login_pgm-manage-user-keys.patch \
            file://wr-policy-allow-setrans_t-dac_read_search.patch \
            file://wr-policy-fix-label-for-dnssec-keys-file.patch \
            file://wr-policy-fix-avc-denials-for-unix_chkpwd-systemd.patch \
            file://wr-policy-make-init_t-fd-useable-by-all-levels.patch \
            file://wr-policy-create-faillogs-with-type-faillog_t.patch \
            file://wr-policy-fix-avc_context_to_sid_raw-assertion-avc_r.patch \
            file://wr-policy-fix-mailx-send-mail-failure.patch \
            file://wr-policy-fix-avc-denials-for-rngd.patch \
            file://wr-policy-fix-avc-denials-for-tcsd.patch \
            file://wr-policy-fix-systemd-logind-fails-to-start.patch \
            file://wr-policy-add-capability-wake_alarm-for-init_t.patch \
            file://wr-policy-fix-auditd-fails-to-start.patch \
            file://wr-refpolicy-some-fixes-for-avc-denials.patch \
            file://wr-policy-fix-avc-denials-for-dhcpc_t.patch \
            file://wr-policy-fix-labels-for-run-resolv.conf.patch \
            file://wr-policy-fix-avc-denials.patch \
            file://wr-policy-allow-local_login_t-search-default_t-dir.patch \
            file://wr-policy-allow-useradd_t-to-write-file-at-all-level.patch \
            file://wr-policy-allow-syslogd_t-search-cgroup_t-dirs.patch \
            file://wr-policy-fixes-for-samba-service.patch \
            file://wr-policy-allow-staff_t-read-etc_t-files.patch \
            file://wr-policy-allow-systemd_logind_t-relabel-user_tmp_t-.patch \
            file://0001-Add-userdom_transition_login_userdomain-interface.patch \
            file://wr-policy-allow-ping_t-read-all-levels-file.patch \
            file://0001-Allow-search-all-pid-dirs-when-managing-net_conf_t-f.patch \
            file://0001-wr-policy-allow-secadm_t-read_policy.patch \
            file://0001-Fix-systemd-resolved-failures.patch \
            file://0001-Fix-error-for-spawning-lib-systemd-systemd.patch \
            file://wr-policy-allow-systemd_backlight_t-read-all-level-f.patch \
           "

# Backport from upstream
SRC_URI += "file://0001-postfix-Silence-cap_dac_read_search-denials.patch \
           "

# Fixes of modular error
SRC_URI += "file://policy-move-xconsole-to-logging-module.patch"

# Fixes could be pushed to upstream
SRC_URI += "file://policy-fix-dev_read_framebuffer.patch \
            file://policy-add-crash-module.patch \
           "
