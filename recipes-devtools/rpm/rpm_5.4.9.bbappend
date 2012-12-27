PRINC = "2"

# We need lua enabled, the rest of the settings match the base configuration
PACKAGECONFIG_virtclass-native = "db bzip2 zlib beecrypt openssl libelf python lua"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://rpm2cpio_segfault.patch \
	"
