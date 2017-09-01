#
# Copyright (C) 2012 Wind River Systems, Inc.
#

inherit core-image

#
# Package groups must be defined here.  Note convention: each group
# "xxx" has a single package dependency on a "packagegroup-xxx" package
# defined in ../packagegroups.
#
FEATURE_PACKAGES_wr-core-util = "packagegroup-wr-core-util"
FEATURE_PACKAGES_wr-core-sys-util = "packagegroup-wr-core-sys-util"
FEATURE_PACKAGES_wr-core-net = "packagegroup-wr-core-net"
FEATURE_PACKAGES_wr-core-interactive = "packagegroup-wr-core-interactive"
FEATURE_PACKAGES_wr-core-libs-extended = "packagegroup-wr-core-libs-extended"
FEATURE_PACKAGES_wr-core-db = "packagegroup-wr-core-db"
FEATURE_PACKAGES_wr-core-perl = "packagegroup-wr-core-perl"
FEATURE_PACKAGES_wr-core-python = "packagegroup-wr-core-python"
FEATURE_PACKAGES_wr-core-lsb-more = "packagegroup-wr-core-lsb-more"
FEATURE_PACKAGES_wr-core-lsb-graphics-plus = "packagegroup-wr-core-lsb-graphics-plus"
FEATURE_PACKAGES_wr-core-mail = "packagegroup-wr-core-mail"
FEATURE_PACKAGES_wr-lsbtest = "packagegroup-wr-lsbtest"
FEATURE_PACKAGES_ssh-sftp-servers ??= ""
FEATURE_PACKAGES_wr-core-cut = "packagegroup-wr-core-cut"

# ensure we have password and group files before we do_rootfs
check_for_passwd_group() {
    if [ ! -f $D/${sysconfdir}/passwd -o ! -f $D/${sysconfdir}/group ]; then
        bberror "Nothing provides ${sysconfdir}/passwd and/or ${sysconfdir}/group"  
	exit 1
    fi
}

ROOTFS_POSTPROCESS_COMMAND_prepend = "check_for_passwd_group ; "

WRPRELIMPKGDATADIR ?= "${TMPDIR}/pkgdata-prelim"
WRPKGDATADIR ?= "${TMPDIR}/pkgdata"

python do_image_info() {
    prelim_dirs = d.getVar('WRPRELIMPKGDATADIR', True) or ""
    built_dirs  = d.getVar('WRPKGDATADIR', True) or ""

    package_install = d.getVar('PACKAGE_INSTALL', True) or ""
    package_install_attemptonly = d.getVar('PACKAGE_INSTALL_ATTEMPTONLY', True) or ""

    globs = d.getVar('IMAGE_INSTALL_COMPLEMENTARY', True) or ""
    for translation in d.getVar('IMAGE_LINGUAS', True).split():
        translated = translation.split('-')[0]
        globs += ' *-locale-%s' % translated
        if translated != translation:
            globs += ' *-locale-%s' % translation

    bb.plain('PKGDATA dirs: %s %s' % (prelim_dirs, built_dirs))
    bb.plain('INSTALL: %s' % package_install)
    bb.plain('INSTALL ATTEMPT: %s' % package_install_attemptonly)
    bb.plain('GLOBS: %s' % globs)
}

addtask image_info
do_image_info[nostamp] = "1"
