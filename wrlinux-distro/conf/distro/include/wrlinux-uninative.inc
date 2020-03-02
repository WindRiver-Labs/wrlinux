#
# This include points at uninative tarballs generated and maintained
# by the Yocto Project. These file can be included by distros if they
# want to use/maintain a unified sstate feed for native/cross artefacts
# rather than the feeds having native/cross artefacts which are specific
# to the distro running on the build machine.
#
# To rebuild uninative tarball:
# - Set SDKMACHINE to "x86_64" or "i686"
# - $ bitbake uninative-tarball
# - Save tmp/deploy/sdk/${SDK_ARCH}-nativesdk-libc.tar.bz2 to a directory <uninative_dir>
# - Update UNINATIVE_URL to <uninative_dir>
# - Update UNINATIVE_CHECKSUM with "sha256sum ${SDK_ARCH}-nativesdk-libc.tar.bz2"
#
INHERIT += "uninative"

YOCTO_UNINATIVE_INC ?= "conf/distro/include/yocto-uninative.inc"
YOCTO_UNINATIVE_INC_poky = ""
require ${YOCTO_UNINATIVE_INC}

# The local fetcher (file://) doesn't verify checksum, which means that there
# is no error when yocto-uninative.inc is updated, this is not what we need.
# Put checksum into UNINATIVE_URL, and move the tarball into a directory named
# by checksum, so that we will get errors when it is updated.
#
UNINATIVE_URL = "file://${LAYER_PATH_wrlinux}/files/uninative-tarballs/${@d.getVarFlag('UNINATIVE_CHECKSUM', '${BUILD_ARCH}')}/"
UNINATIVE_CHECKSUM[aarch64] = "e76a45886ee8a0b3904b761c17ac8ff91edf9811ee455f1832d10763ba794dfc"
UNINATIVE_CHECKSUM[i686] = "810d027dfb1c7675226afbcec07808770516c969ee7378f6d8240281083f8924"
UNINATIVE_CHECKSUM[x86_64] = "9498d8bba047499999a7310ac2576d0796461184965351a56f6d32c888a1f216"
