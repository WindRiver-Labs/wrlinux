FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += " \
    ${@bb.utils.contains('PACKAGECONFIG', 'POSIX_26', 'file://0001-Add-support-for-posix_devctl.patch', '', d)} \
"

PACKAGECONFIG[POSIX_26] = ",,,"
