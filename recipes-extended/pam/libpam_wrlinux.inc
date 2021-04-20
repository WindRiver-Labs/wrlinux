#
# Add a few "redhat" modules to pam.  Some have been accepted upstream and
# are part of the distribution, but not the three we add here.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/libpam:"

SRC_URI += "https://src.fedoraproject.org/repo/pkgs/pam/pam-redhat-1.1.4.tar.bz2/sha512/ad3b53744505faf7c93b1f0c1ef4434c2567b97e292859963401b0c117e824704713c69f7a661cccd3aecd1208facb39c433703c1f3cdea1dbda2c380006bfc4/pam-redhat-1.1.4.tar.bz2;name=redhat \
            file://pam-1.0.90-redhat-modules.patch \
            file://pam_console_deps.patch \
            file://0001-drop-yylex-to-static-force.patch \
	    ${@bb.utils.contains('PACKAGECONFIG', 'faillock', '\
	    file://pam_faillock_add_uid.patch \
	    file://0001-faillock-create-dir-before-create-tally-file.patch', '', d)} \
           "

SRC_URI[redhat.md5sum] = "17bf8913b480e63d9464b5ba203a52a7"
SRC_URI[redhat.sha256sum] = "c378e439d331b82e08010eac700e1eff920cd4d6175b7c522d499d97ed8e1838"

EXTRA_OEMAKE_append = " LOCKDIR=${localstatedir}/run/console"

# If necessary, move pam-redhat modules to where they will be built.
# We create a local function and use sh.
#
do_lcl_rh_move () {
	SAVED_PWD=`pwd`; cd ${S}
	if [ ! -e modules/pam_console ] ; then
		mv ${WORKDIR}/pam-redhat-1.1.4/* modules
	fi
	cd ${SAVED_PWD}
}

# Now, we define our own do_patch.  We rely on the fact
# that the default do_patch just invokes patch_do_patch.
#
python do_patch () {
    bb.build.exec_func('do_lcl_rh_move', d)
    bb.build.exec_func('patch_do_patch', d)
}

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

    if ${@bb.utils.contains('DISTRO_FEATURES','sysvinit','false','true',d)}; then
        echo "d /var/run/console 0755 root root - -" >>  ${D}${sysconfdir}/tmpfiles.d/pam.conf
    else
        echo "d root root 0755 /var/run/console none" >> ${D}${sysconfdir}/default/volatiles/99_pam
    fi
}

PACKAGECONFIG[faillock] = ",,,"
RDEPENDS_${PN}-runtime += "${@bb.utils.contains('PACKAGECONFIG', 'faillock', 'pam-plugin-faillock', '', d)}"
