#
# Copyright (C) 2012 - 2014 Wind River Systems Inc.
#
# Deploy native recipes' sstate-cache files which are in
# ${B}/sstate-cache:
# - populate_lic.tgz
# - populate_lic.tgz.siginfo
# - populate_sysroot.tgz
# - populate_sysroot.tgz.siginfo
# - package_qa.tgz
# - package_qa.tgz.siginfo
#

DESCRIPTION = "A list of commonly used native packages."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PR = "r2"

inherit native

do_fetch[noexec] = "1"
do_unpack[noexec] = "1"
do_patch[noexec] = "1"
do_configure[noexec] = "1"
do_compile[noexec] = "1"
do_install[noexec] = "1"
do_populate_sysroot[noexec] = "1"
do_populate_lic[noexec] = "1"

# Make do_populate_lic, do_package_qa and do_populate_sysroot done
do_build[deptask] += "do_populate_lic do_package_qa do_populate_sysroot"

NATIVE_SS_OUTPUT_DIR ?= "${DEPLOY_DIR}/sstate-native"
NATIVE_SS_OUTPUT_NAME ?= "host-tools-${BUILD_ARCH}"
NATIVE_SS_OUTPUT ?= "${DEPLOY_DIR}/sstate-native/host-tools-${BUILD_ARCH}.tar.gz"

# The list of common native packages. This list is generated using
# wrlinux-x/scripts/gen_common_native_package_list.sh
require wr-common-packages-native.inc

X11_BLACKLIST ?= "\
    font-util-native \
    libfontenc-native \
    libice-native \
    libsm-native \
    libx11-native \
    libxau-native \
    libxcb-native \
    libxdmcp-native \
    libxext-native \
    libxrender-native \
    mkfontscale-native \
    xtrans-native \
"
DEPENDS_remove = "${@bb.utils.contains('DISTRO_FEATURES', 'x11', '', '${X11_BLACKLIST}', d)}"

do_deploy_sstate () {
    if [ -d "${SSTATE_DIR}" ]; then
        # Check the sstate cache files
        found="`find ${SSTATE_DIR} -name '*_configure.tgz.siginfo' | wc -l`"
        if [ "$found" != "0" ]; then
            bbfatal "Found configure sstate files in ${SSTATE_DIR}, but should not!"
        fi
        cd ${SSTATE_DIR}/../ || exit 1
        mkdir -p ${NATIVE_SS_OUTPUT_DIR} || exit 1
        bbnote "Creating ${NATIVE_SS_OUTPUT}"
        tar --exclude='*.tgz.done' --exclude='*.siginfo.done' \
            --transform 's#sstate-cache#${NATIVE_SS_OUTPUT_NAME}#' \
            -czhf "${NATIVE_SS_OUTPUT}" sstate-cache
    else
        bbfatal "No ${SSTATE_DIR}, nothing to deploy"
    fi
}

do_deploy_sstate[deptask] += "do_populate_lic do_package_qa do_populate_sysroot"
addtask deploy_sstate
