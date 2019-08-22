FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRCREV = "870a6018c34644e5f9428c8913a206dc53be6fd7"
SRC_URI = "git://github.com/OpenSCAP/scap-security-guide.git \
            file://0001-update-auditd-service-path.patch \
            file://0002-Update-installed-package-environment-check.patch \
            file://0003-Add-sssd-platform-to-WRLinux1019-CPE-directory.patch \
            file://0004-Subject-PATCH-Update-installed-package-yum-environme.patch \
            file://0005-Add-rule-accounts_passwords_pam_tally2_deny-instead-.patch \
            file://0006-Add-WRLinux1019-test-case-for-rule-package_openssh-s.patch \
            file://0007-Add-WRLinux1019-and-WRLinux8-test-case-for-rule-acco.patch \
            file://0008-Fix-rule-accounts_password_pam_unix_remember-remedia.patch \
            file://0009-Add-var-var_accounts_passwords_pam_tally2_deny.patch \
            file://0010-Add-rule-accounts_passwords_pam_tally2_deny_root-tes.patch \
            file://0011-Add-rules-accounts_passwords_pam_tally2_deny_root-an.patch \
            file://0012-Update-rules-accounts_passwords_pam_tally2_deny-and-.patch \
            file://0013-Add-WRLinux1019-test-case-for-rule-accounts_password.patch \
            file://0014-Remove-accounts_password_pam_retry-and-add-cracklib_.patch \
            file://0015-Add-WRLinux1019-specific-test-case-for-rule-set_pass.patch \
            file://0016-Add-WRLinux1019-specific-code-to-rule-display_login_.patch \
            file://0017-Add-WRLinux1019-specific-remediation-script-for-rule.patch \
            file://0018-Add-WRLinux1019-specific-code-for-rule-require_singl.patch \
            file://0019-Use-WRLinux1019-package-samhain-to-do-integrity-work.patch \
            file://0020-Add-rule-accounts_passwords_pam_tally2_interval-for-.patch \
            file://0021-Update-shared.yml-in-accounts_passwords_pam_tally2_d.patch \
            file://0022-Fix-rule-accounts_passwords_pam_tally2_interval-reme.patch \
            file://0023-Add-iptable-relevant-rules.patch \
            file://0024-Add-WRLinux-specific-rule-package_strongswan_install.patch \
            file://0025-Add-WRLinux1019-rule-file_groupowner_cron_allow.patch \
            file://0026-Add-WRLinux1019-oval-and-remediate-code-for-service_.patch \
            file://0027-Add-oval-test-case-package_kexec-tools_removed-speci.patch \
            file://0028-Add-WRLinux1019-specific-oval-check-for-rule-file_ow.patch \
            file://0029-Add-WRLinux1019-oval-check-for-rule-package_vsftpd_r.patch \
            file://0030-Add-WRLinux1019-oval-check-for-rule-mount_option_krb.patch \
            file://0031-Add-WRLinux1019-oval-check-for-rule-service_ntpd_ena.patch \
            file://0032-Add-WRLinux1019-oval-check-rule-package_ypserv_remov.patch \
            file://0033-Add-WRLinux1019-oval-check-for-rule-package_rsh-serv.patch \
            file://0034-Add-WRLinux1019-oval-check-for-rule-package_telnet-s.patch \
            file://0035-Add-WRLinux1019-oval-check-for-rule-package_tftp-ser.patch \
            file://0036-Add-WRLinux1019-oval-check-for-rule-package_ntp_inst.patch \
            file://0037-Rule-file_permissions_sshd_private_key-add-WRLin.patch \
            file://0038-Rule-file_permissions_sshd_pub_key-add-WRLinux1019-oval-c.patch \
            file://0039-Rule-service_sshd_enabled-add-WRLinux1019-oval-check.patch \
            file://0040-Rule-package_screen_installed-add-oval-check.patch \
            file://0041-Rule-service_auditd_enabled-add-oval-check.patch \
            file://0042-Rule-kernel_module_usb-storage_disabled-add-oval-che.patch \
            file://0043-Rule-service_autofs_disabled-add-oval-check.patch \
            file://0044-Rule-cracklib_accounts_password_pam_dcredit-add-oval.patch \
            file://0045-Rule-cracklib_accounts_password_pam_difok-add-oval-c.patch \
            file://0046-Rule-cracklib_accounts_password_pam_lcredit-add-oval.patch \
            file://0047-Rule-cracklib_accounts_password_pam_maxrepeat-add-ov.patch \
            file://0048-Rule-cracklib_accounts_password_pam_minclass-add-oval-check.patch \
            file://0049-Rule-cracklib_accounts_password_pam_ocredit-add-oval-check.patch \
            file://0050-Rule-cracklib_accounts_password_pam_ucredit-add-oval-check.patch \
            file://0051-Replace-rules-accounts_password_pam_-with-cracklib_a.patch \
            file://0052-Rule-dac_modification_chmod-add-oval-check-and-remed.patch \
            file://0053-Rule-audit_rules_dac_modification_chown-add-oval-che.patch \
            file://0054-Rule-audit_rules_dac_modification_fchmod-add-oval-ch.patch \
            file://0055-Rule-audit_rules_dac_modification_fchmodat-add-oval-.patch \
            file://0056-Rule-audit_rules_dac_modification_fchown-add-oval-ch.patch \
            file://0057-Rule-audit_rules_dac_modification_fchownat-add-oval-.patch \
            file://0058-Rule-audit_rules_dac_modification_fremovexattr-add-o.patch \
            file://0059-Rule-audit_rules_dac_modification_fsetxattr-add-oval.patch \
            file://0060-Rule-audit_rules_dac_modification_lchown-add-oval-ch.patch \
            file://0061-Rule-audit_rules_dac_modification_lremovexattr-add-o.patch \
            file://0062-Rule-audit_rules_dac_modification_lsetxattr-add-oval.patch \
            file://0063-Rule-audit_rules_dac_modification_removexattr-add-ov.patch \
            file://0064-Rule-audit_rules_dac_modification_setxattr-add-oval-.patch \
            file://0065-Rule-audit_rules_execution_chcon-add-oval-check-and-.patch \
            file://0066-Rule-audit_rules_execution_semanage-add-oval-check-a.patch \
            file://0067-Rule-audit_rules_execution_setsebool-add-oval-check-.patch \
            file://0068-Rule-audit_rules_file_deletion_events-add-oval-check.patch \
            file://0069-Rule-audit_rules_unsuccessful_file_modification-add-.patch \
            file://0070-Use-rule-audit_rules_file_deletion_events-to-replace.patch \
            file://0071-Use-rule-audit_rules_unsuccessful_file_modification-.patch \
            file://0072-Rule-audit_rules_privileged_commands_chage-add-oval-.patch \
            file://0073-Rule-audit_rules_privileged_commands_chsh-add-oval-c.patch \
            file://0074-Rule-audit_rules_privileged_commands_crontab-add-ova.patch \
            file://0075-Rule-audit_rules_privileged_commands_gpasswd-add-ova.patch \
            file://0076-Rule-audit_rules_privileged_commands_pam_timestamp_c.patch \
            file://0077-Rule-audit_rules_privileged_commands_passwd-add-oval.patch \
            file://0078-Rule-audit_rules_privileged_commands_postdrop-add-ov.patch \
            file://0079-Rule-audit_rules_privileged_commands_postqueue-add-o.patch \
            file://0080-Rule-audit_rules_privileged_commands_ssh_keysign-add.patch \
            file://0081-Rule-audit_rules_privileged_commands_su-add-oval-che.patch \
            file://0082-Rule-audit_rules_privileged_commands_sudo-add-oval-c.patch \
            file://0083-Rule-audit_rules_privileged_commands_umount-add-oval.patch \
            file://0084-Rule-audit_rules_privileged_commands_pam_timestamp_c.patch \
            file://0085-Fix-audit_rules_privileged_commands-related-rules-fa.patch \
            file://0086-Update-commands-path-in-audit_rules_privileged_comma.patch \
            file://0087-Rule-sysctl_net_ipv6_conf_all_accept_source_route-ad.patch \
            file://0088-Rule-sysctl_net_ipv4_conf_all_accept_redirects-add-o.patch \
            file://0089-Rule-sysctl_net_ipv4_conf_all_accept_source_route-ad.patch \
            file://0090-Rule-sysctl_net_ipv4_icmp_echo_ignore_broadcasts-add.patch \
            file://0091-Rule-sysctl_net_ipv4_conf_all_send_redirects-add-ova.patch \
            file://0092-Rule-sysctl_net_ipv4_conf_default_send_redirects-add.patch \
            file://0093-Rule-sysctl_net_ipv4_ip_forward-add-oval-check.patch \
            file://0094-Rule-kernel_module_dccp_disabled-add-oval-check.patch \
            file://0095-Rule-sysctl_net_ipv4_conf_all_send_redirects-add-bas.patch \
            file://0096-Rule-sysctl_net_ipv4_conf_default_send_redirects-add.patch \
            file://0097-Rule-sysctl_net_ipv4_ip_forward-add-bash-script.patch \
            file://0098-Rule-kernel_module_dccp_disabled-add-bash-script.patch \
            file://0099-Rule-sysctl_net_ipv4_conf_default_accept_source_rout.patch \
            file://0100-Add-rules-package_openssh-sshd_installed-and-package.patch \
            file://0101-Fix-rule-audit_rules_privileged_commands-error-after.patch \
            file://0102-Rule-postfix_client-postfix_network_listening_disabl.patch \
            file://0103-Rule-service_ntpdate_disabled-add-oval-check.patch \
            file://0104-Remove-rule-configure_firewalld_ports-from-WRLinux10.patch \
           "
PV = "0.1.45+git${SRCPV}"

EXTRA_OECMAKE += "-DSSG_PRODUCT_CHROMIUM=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_DEBIAN8=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_FEDORA=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_FIREFOX=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_EAP6=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_FUSE6=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_JRE=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_OCP3=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_OL7=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_OL8=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_OPENSUSE=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHEL6=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHEL7=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHEL8=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHOSP13=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_RHV4=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_SLE11=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_SLE12=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_UBUNTU1404=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_UBUNTU1604=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_UBUNTU1804=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_WRLINUX8=OFF"
EXTRA_OECMAKE += "-DSSG_PRODUCT_WRLINUX1019=ON"
