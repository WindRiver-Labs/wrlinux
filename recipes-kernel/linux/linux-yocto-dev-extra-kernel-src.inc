TEMP_KERNEL_FILES ?= ""
TEMP_KERNEL_SRC_URI ?= ""

FIX_VBOX_PATCH = "file://0001-mm-vmalloc.c-export-two-api-symbol-to-fix-vbox-build.patch"
TEMP_KERNEL_FILES_qemux86 = "${THISDIR}/linux-yocto:"
TEMP_KERNEL_FILES_qemux86-64 = "${THISDIR}/linux-yocto:"
TEMP_KERNEL_FILES_intel-x86-64 = "${THISDIR}/linux-yocto:"
TEMP_KERNEL_SRC_URI_qemux86 = "${FIX_VBOX_PATCH}"
TEMP_KERNEL_SRC_URI_qemux86-64 = "${FIX_VBOX_PATCH}"
TEMP_KERNEL_SRC_URI_intel-x86-64 = "${FIX_VBOX_PATCH}"

EXTRA_KERNEL_FILES =. "${TEMP_KERNEL_FILES}"
EXTRA_KERNEL_SRC_URI += "${TEMP_KERNEL_SRC_URI}"
