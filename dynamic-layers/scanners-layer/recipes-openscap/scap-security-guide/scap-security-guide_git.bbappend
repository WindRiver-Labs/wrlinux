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
