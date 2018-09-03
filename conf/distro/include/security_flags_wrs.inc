# Base on oe-core security flags
include conf/distro/include/security_flags.inc

# To override for multilib, use SECURITY_CFLAGS_pn-<pkg>_pn-<mlib>-<pkg>.
# If just SECURITY_CFLAGS_pn-<pkg> is defined, it will be used for all
# multilib variants, too.

# Reason: The recipe vdso-test located in wrlinux which has assemble code
SECURITY_CFLAGS_pn-vdso-test = ""

# Reason:
# upstream meta-secure-core refuse to set var-SECURITY_STACK_PROTECTOR to
# LDFLAGS and upstream oe-core refuse to remove var-SECURITY_STACK_PROTECTOR
# from LDFLAGS
SECURITY_LDFLAGS_remove_pn-libsign = "-fstack-protector-strong"

