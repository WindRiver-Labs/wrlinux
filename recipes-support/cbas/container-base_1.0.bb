#
# Copyright (C) 2020 Wind River Systems, Inc.
#
DESCRIPTION = "Provides container base app sdk for CBAS."

LICENSE = "MIT"

# Control the installed packages strictly
WRTEMPLATE_IMAGE = "0"

# Implementation of Full Image generator with Application SDK
TOOLCHAIN_HOST_TASK_append = " \
    nativesdk-wic \
    nativesdk-create-full-image \
    nativesdk-bootfs \
    nativesdk-appsdk \
"
TOOLCHAIN_TARGET_TASK_append = " qemuwrapper-cross"

POPULATE_SDK_PRE_TARGET_COMMAND += "copy_pkgdata_to_sdk;"
copy_pkgdata_to_sdk() {
    install -d ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/pkgdata
    cp -rf ${PKGDATA_DIR} ${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/pkgdata/
}

inherit wrlinux-image features_check
REQUIRED_DISTRO_FEATURES = "ostree cbas"
