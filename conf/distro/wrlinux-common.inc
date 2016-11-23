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
TOOLCHAINEXT_OUTPUTNAME = "${DISTRO}-${DISTRO_VERSION}-${TCLIBC}-${SDK_ARCH}${TCSDKMACH}-${MACHINE_ARCH}-${PN}-sdk-ext"

TOOLCHAIN_OUTPUTNAME_pn-buildtools-tarball_forcevariable = "${SDK_ARCH}-buildtools-nativesdk-standalone-${DISTRO_VERSION}"

# Workaround for extensible SDK
TOOLCHAIN_OUTPUTNAME_pn-uninative-tarball = "${SDK_ARCH}-nativesdk-libc"

WRSDK_RDEPENDS ?= "\
        nativesdk-cmake \
        nativesdk-mtools \
        nativesdk-rpm-common \
        nativesdk-syslinux \
        nativesdk-unfs3 \
        nativesdk-util-linux \
"

# We must disable this for a mingw sdk!
WRSDK_RDEPENDS_sdkmingw32 = ""

# eSDk doesn't need extra TOOLCHAIN_HOST_TASK, eSDK ships
# buildtools-tarball which includes them.
WRSDK_RDEPENDS_task-populate-sdk-ext = ""

TOOLCHAIN_HOST_TASK_append = " ${WRSDK_RDEPENDS}"

# Add changelist.xml and fs_final*.sh processing
IMAGE_CLASSES += "image-fs_finalize"

# Override these in wrlinux based distros to modify DISTRO_EXTRA_R*
WRLINUX_DEFAULT_EXTRA_RDEPENDS = "packagegroup-core-boot"
WRLINUX_DEFAULT_EXTRA_RRECOMMENDS = "kernel-module-af-packet"

DISTRO_EXTRA_RDEPENDS += " ${WRLINUX_DEFAULT_EXTRA_RDEPENDS}"
DISTRO_EXTRA_RRECOMMENDS += " ${WRLINUX_DEFAULT_EXTRA_RRECOMMENDS}"

# do not include qemu-config by default
#WRLINUXQEMUDEPS = "${@bb.utils.contains("INCOMPATIBLE_LICENSE", "GPLv3", "", "qemu-config",d)}"
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
CONNECTIVITY_CHECK_URIS ?= "https://www.example.com/"

# Default hash policy for distro
BB_SIGNATURE_HANDLER ?= 'OEBasicHash'

# Add our license to the acceptable restricted license list
LICENSE_FLAGS_WHITELIST += "commercial_windriver"

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

# lsb distro adjust
require conf/distro/include/wrlinux-lsb-distro-adjust.inc

# Make sure DISTRO_FEATURES backfill has pulseaudio 
# this is a temporary fix until pulseaudio is fixed

DISTRO_FEATURES_BACKFILL_CONSIDERED += " pulseaudio"

# Multilib configuration
MULTILIBS ?= ""
require conf/multilib.conf

PACKAGECONFIG_pn-sysstat = "lm-sensors"

# we usually use gnutls as the default PACKAGECONFIG of wpa-supplicant, but its sub-packege gnutls-openssl
# is GPLv3, so need this check to switch to openssl if GLPv3 is blacklisted.
PACKAGECONFIG_pn-wpa-supplicant = "${@bb.utils.contains('INCOMPATIBLE_LICENSE', 'GPLv3', 'openssl', 'gnutls', d)}"

require conf/distro/include/wrlinux-distro-settings.conf

require conf/distro/include/wrlinux-uninative.inc

# Exclude download layers from eSDK.
SDK_LAYERS_EXCLUDE_PATTERN ?= ".*-dl$ .*-dl-2.2$"
