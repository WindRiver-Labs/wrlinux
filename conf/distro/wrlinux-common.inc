#
# Copyright (C) 2012 Wind River Systems, Inc.
#
# information common to all wrlinux distros
#

# Wind River assumes that we want 32-bit pseudo wrappers, so enable
# them by default, but allow a knowledgable user to override the setting
#
# OE-Core default is set in the pseudo recipe and defaults to '1'.
#
NO32LIBS ?= "0"

MAINTAINER = "Wind River <info@windriver.com>"

TARGET_VENDOR = "-wrs"

LOCALCONF_VERSION = "1"

SDK_NAME = "${DISTRO}-${TCLIBC}-${SDK_ARCH}-${TARGET_ARCH}"
SDKPATH = "/opt/windriver/${DISTRO}/${SDK_VERSION}"
TOOLCHAIN_OUTPUTNAME = "${DISTRO}-${DISTRO_VERSION}-${TCLIBC}-${SDK_ARCH}-${MACHINE_ARCH}-${PN}-sdk"

# Add changelist.xml and fs_final*.sh processing
INHERIT += "image-fs_finalize"

# Add the ability to generate the companion debuginfo filesystem
# To enable the image set IMAGE_GEN_DEBUGFS = "1"
INHERIT += "image-debuginfo"
BB_HASHBASE_WHITELIST_append += "IMAGE_GEN_DEBUGFS"

# Override these in wrlinux based distros to modify DISTRO_EXTRA_R*
WRLINUX_DEFAULT_EXTRA_RDEPENDS = "packagegroup-core-boot"
WRLINUX_DEFAULT_EXTRA_RRECOMMENDS = "kernel-module-af-packet"

DISTRO_EXTRA_RDEPENDS += " ${WRLINUX_DEFAULT_EXTRA_RDEPENDS}"
DISTRO_EXTRA_RRECOMMENDS += " ${WRLINUX_DEFAULT_EXTRA_RRECOMMENDS}"

# do not include qemu-config by default
#WRLINUXQEMUDEPS = "${@base_contains("INCOMPATIBLE_LICENSE", "GPLv3", "", "qemu-config",d)}"
WRLINUXQEMUDEPS = ""

DISTRO_EXTRA_RDEPENDS_append_qemuarm = " ${WRLINUXQEMUDEPS}"
DISTRO_EXTRA_RDEPENDS_append_qemumips = " ${WRLINUXQEMUDEPS}"
DISTRO_EXTRA_RDEPENDS_append_qemuppc = " ${WRLINUXQEMUDEPS}"
DISTRO_EXTRA_RDEPENDS_append_qemux86 = " ${WRLINUXQEMUDEPS}"
DISTRO_EXTRA_RDEPENDS_append_qemux86-64 = " ${WRLINUXQEMUDEPS}"

TCLIBCAPPEND = ""

#default locale / local language processing settings
IMAGE_LINGUAS ?= ""

QEMU_TARGETS ?= "arm i386 mips mipsel mips64 mips64el ppc x86_64"
# Other QEMU_TARGETS "sh4"

MIRRORS =+ "\
ftp://.*/.*      http://downloads.yoctoproject.org/mirror/sources/ \n \
http://.*/.*     http://downloads.yoctoproject.org/mirror/sources/ \n \
https://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \n"

# The CONNECTIVITY_CHECK_URI's are used to test whether we can succesfully
# fetch from the network (and warn you if not). To disable the test set
# the variable to be empty.
CONNECTIVITY_CHECK_URIS ?= "git://git.yoctoproject.org/yocto-firewall-test;protocol=git;rev=HEAD \
                          https://eula-downloads.yoctoproject.org/index.php \
                          http://bugzilla.yoctoproject.org/report.cgi"

# Default hash policy for distro
BB_SIGNATURE_HANDLER ?= 'OEBasicHash'

# Add our license to the acceptable restricted license list
LICENSE_FLAGS_WHITELIST += "commercial_windriver"

# Don't include a /etc/hostname file in our rootfs
hostname_pn-base-files ?= ""

# QA check settings - a little stricter than the OE-Core defaults
# Enable QA warnings related to split of / and /usr
WARN_QA ?= "textrel files-invalid incompatible-license xorg-driver-abi \
            libdir unsafe-references-in-binaries unsafe-references-in-scripts \
            ldflags installed-vs-shipped"
ERROR_QA ?= "dev-so debug-deps dev-deps debug-files arch pkgconfig la perms \
            useless-rpaths rpaths staticdev pkgvarcheck already-stripped \
            compile-host-path dep-cmp install-host-path \
            packages-list perm-config perm-line perm-link pkgv-undefined \
            pn-overrides split-strip var-undefined version-going-backwards"

# Change base package dependency in -dbg packages from recommends to suggests
RRECOMMENDS_${PN}-dbg = ""
RSUGGESTS_${PN}-dbg = "${PN} (= ${EXTENDPKGV})"

# Extra host tool packages
require conf/distro/include/wr-host-tools.inc

# Blacklist recipes we explicitly disallow in wrlinux
require conf/distro/blacklist.conf

# Make sure DISTRO_FEATURES backfill has pulseaudio 
# this is a temporary fix until pulseaudio is fixed

DISTRO_FEATURES_BACKFILL_CONSIDERED += " pulseaudio"

# Enable gcc 4.8
# - unless we're using e500 or e500v2
#   -- see https://bugzilla.yoctoproject.org/show_bug.cgi?id=4495
GCCVERSION = "${@['4.8%', '4.7%'][d.getVar("DEFAULTTUNE", True) in ['ppce500', 'ppce500v2']]}"
EGLIBCVERSION = "${@['2.18%', '2.17%'][d.getVar("DEFAULTTUNE", True) in ['ppce500', 'ppce500v2']]}"

# Multilib configuration
MULTILIBS ?= ""
require conf/multilib.conf

PACKAGECONFIG_pn-sysstat = "lm-sensors"
