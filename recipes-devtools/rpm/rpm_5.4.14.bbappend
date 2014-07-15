# We need lua enabled, the rest of the settings match the base configuration
PACKAGECONFIG_virtclass-native = "db bzip2 zlib beecrypt openssl libelf python lua"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://rpm2cpio_segfault.patch \
           "
# rpm2cpio, when pulled from an sstate cache, might not work,
# so we use this handy script version, instead.
#
do_install_append_virtclass-native() {
        cp ${S}/scripts/rpm2cpio ${D}/${bindir}
}
