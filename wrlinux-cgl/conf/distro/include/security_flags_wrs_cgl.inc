SECURITY_CFLAGS_pn-cgl-unittest = "${SECURITY_NOPIE_CFLAGS}"
SECURITY_CFLAGS_pn-gen-coredump = "${SECURITY_NOPIE_CFLAGS}"

# For any distro, gcc will usually be set to build pie code by default.  SECURITY_NOPIE_CFLAGS
# overrides this so we usually want to append that to other security flags rather than replace them.
#
SECURITY_CFLAGS_append_pn-go-dep_mips64 = " ${SECURITY_NOPIE_CFLAGS}"
