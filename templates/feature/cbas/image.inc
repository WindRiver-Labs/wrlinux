# Implementation of Full Image generator with Application SDK
TOOLCHAIN_HOST_TASK_append = " \
    nativesdk-wic \
    nativesdk-create-full-image \
    nativesdk-bootfs \
"
TOOLCHAIN_TARGET_TASK_append = " qemuwrapper-cross"
