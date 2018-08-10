require linux-yocto-wrlinux.inc
include srcrev.inc
require extra-kernel-src.inc

# This variable should have been updated in oe-core/meta/recipes-kernel/linux/linux-yocto.inc,
# but not yet. To not touch oe-core locally, we temporarily set it here. Once it's
# done upstream, this should be removed.
LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
