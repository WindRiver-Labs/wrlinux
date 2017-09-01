#
# Add a few "redhat" modules to pam.  Some have been accepted upstream and
# are part of the distribution, but not the three we add here.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Note how we "name" the checksums.
#
SRC_URI += "http://pkgs.fedoraproject.org/repo/pkgs/pam/pam-redhat-0.99.11.tar.bz2/29eab110f57e8d60471081a6278a5a92/pam-redhat-0.99.11.tar.bz2;name=redhat \
            file://pam-1.0.90-redhat-modules.patch \
            file://pam-1.1.0-console-nochmod.patch \
            file://pam_console_deps.patch \
           "

SRC_URI[redhat.md5sum] = "29eab110f57e8d60471081a6278a5a92"
SRC_URI[redhat.sha256sum] = "82bd4dc8c79d980bfc8421908e7562a63f0c65cc61152e2b73dcfb97dbf1681b"

EXTRA_OEMAKE_append = " LOCKDIR=${localstatedir}/run/console"

# If necessary, move pam-redhat modules to where they will be built.
# We create a local function and use sh.
#
do_lcl_rh_move () {
	SAVED_PWD=`pwd`; cd ${S}
	if [ ! -e modules/pam_console ] ; then
		mv ${WORKDIR}/pam-redhat-0.99.11/* modules
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

python do_pam_sanity_append () {
    if not bb.utils.contains('DISTRO_FEATURES', 'pam', True, False, d):
        bb.error("Building libpam but 'pam' isn't in DISTRO_FEATURES.  You may want to add DISTRO_FEATURES_append=\"pam\" to local.conf.")
}
