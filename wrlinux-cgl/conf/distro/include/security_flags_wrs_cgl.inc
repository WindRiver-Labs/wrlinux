SECURITY_CFLAGS_pn-corosync = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-dconf = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-device-mapper-multipath = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-efivar = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-gperftools = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-ippool = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-libsigc++-2.0 = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-openhpi = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-openldap = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-poppler = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-rrdtool = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-leveldb = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-snappy = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-tpm2.0-tss = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-nagios-core = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-ceph = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-cgl-unittest = "${SECURITY_NOPIE_CFLAGS}"
SECURITY_CFLAGS_pn-gen-coredump = "${SECURITY_NOPIE_CFLAGS}"

# For any distro, gcc will usually be set to build pie code by default.  SECURITY_NOPIE_CFLAGS
# overrides this so we usually want to append that to other security flags rather than replace them.
#
SECURITY_CFLAGS_append_pn-go-dep_mips64 = " ${SECURITY_NOPIE_CFLAGS}"
