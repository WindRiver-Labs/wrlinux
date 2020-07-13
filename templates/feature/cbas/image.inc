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
