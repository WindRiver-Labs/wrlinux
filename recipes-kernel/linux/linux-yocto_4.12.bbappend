require linux-yocto-wrlinux.inc
include srcrev.inc
require extra-kernel-src.inc

KBRANCH_qemux86  ?= "standard/wr-base"
KBRANCH_qemux86-64 ?= "standard/wr-base"
