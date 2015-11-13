#
# Copyright (C) 2012 - 2015 Wind River Systems, Inc.
#
# information common to all wrlinux distros
#

MAINTAINER = "Wind River <info@windriver.com>"

TARGET_VENDOR = "-wrs"

LOCALCONF_VERSION = "1"

SDK_NAME = "${DISTRO}-${TCLIBC}-${SDK_ARCH}-${TARGET_ARCH}"
SDKPATH = "/opt/windriver/${DISTRO}/${SDK_VERSION}"
TCSDKMACH = "${@['', '_${SDK_OS}']['${SDK_OS}' != 'linux']}"
TOOLCHAIN_OUTPUTNAME = "${DISTRO}-${DISTRO_VERSION}-${TCLIBC}-${SDK_ARCH}${TCSDKMACH}-${MACHINE_ARCH}-${PN}-sdk"

# Add changelist.xml and fs_final*.sh processing
IMAGE_CLASSES += "image-fs_finalize"

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

QEMU_TARGETS ?= "arm aarch64 i386 mips mipsel mips64 mips64el ppc ppc64 x86_64"
# Other QEMU_TARGETS "sh4"

MIRRORS =+ "\
ftp://.*/.*      http://downloads.yoctoproject.org/mirror/sources/ \n \
http://.*/.*     http://downloads.yoctoproject.org/mirror/sources/ \n \
https://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \n"

# The CONNECTIVITY_CHECK_URI's are used to test whether we can succesfully
# fetch from the network (and warn you if not). To disable the test set
# the variable to be empty.
CONNECTIVITY_CHECK_URIS ?= "https://eula-downloads.yoctoproject.org/index.php \
                          http://bugzilla.yoctoproject.org/report.cgi"

# Default hash policy for distro
BB_SIGNATURE_HANDLER ?= 'OEBasicHash'

# Add our license to the acceptable restricted license list
LICENSE_FLAGS_WHITELIST += "commercial_windriver"

# Don't include a /etc/hostname file in our rootfs
hostname_pn-base-files ?= ""

# QA check settings - a little stricter than the OE-Core defaults
WARN_TO_ERROR_QA = "already-stripped compile-host-path install-host-path \
                    pn-overrides staticdev useless-rpaths"
WARN_QA_remove = "${WARN_TO_ERROR_QA}"
ERROR_QA_append = " ${WARN_TO_ERROR_QA}"

# Allow dangling .bbappends for now
BB_DANGLINGAPPENDS_WARNONLY = "1"

# Change base package dependency in -dbg packages from recommends to suggests
RRECOMMENDS_${PN}-dbg = ""
RSUGGESTS_${PN}-dbg = "${PN} (= ${EXTENDPKGV})"

# Extra host tool packages
require conf/distro/include/wrlinux-host-tools.inc

# Blacklist recipes we explicitly disallow in wrlinux
require conf/distro/include/wrlinux-blacklist.conf

# Whitelist recipes we explicitly sallow in wrlinux
require conf/distro/include/wrlinux-whitelist.conf

# Make sure DISTRO_FEATURES backfill has pulseaudio 
# this is a temporary fix until pulseaudio is fixed

DISTRO_FEATURES_BACKFILL_CONSIDERED += " pulseaudio"

# Multilib configuration
MULTILIBS ?= ""
require conf/multilib.conf

PACKAGECONFIG_pn-sysstat = "lm-sensors"
PACKAGECONFIG_pn-${MLPREFIX}ntp = "openssl cap"

require conf/distro/include/wrlinux-exclude-from-world.conf
require conf/distro/include/wrlinux-distro-settings.conf
