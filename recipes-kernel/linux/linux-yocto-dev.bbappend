require linux-yocto-wrlinux.inc
require extra-kernel-src.inc

FILESEXTRAPATHS_prepend_qemumips64 := "${THISDIR}/linux-yocto-dev:"
SRC_URI_append_qemumips64 = " \
  file://0001-Revert-mips-Add-clock_gettime64-entry-point.patch \
  file://0002-Revert-mips-vdso-Fix-__arch_get_hw_counter.patch \
  file://0003-Revert-mips-Add-clock_getres-entry-point.patch \
  file://0004-Revert-MIPS-VDSO-Fix-build-for-binutils-2.25.patch \
  file://0005-Revert-mips-vdso-Fix-flip-flop-vdso-building-bug.patch \
  file://0006-Revert-mips-Add-support-for-generic-vDSO.patch \
  "
