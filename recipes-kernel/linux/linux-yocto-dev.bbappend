require linux-yocto-wrlinux.inc
include srcrev.inc

EXTRA_KERNEL_FILES = "${THISDIR}/files"
EXTRA_KERNEL_SRC_URI = "file://0001-scripts-gcc-goto.sh-print-message.patch"
require extra-kernel-src.inc

# This variable should have been updated in oe-core/meta/recipes-kernel/linux/linux-yocto.inc,
# but not yet. To not touch oe-core locally, we temporarily set it here. Once it's
# done upstream, this should be removed.
LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
