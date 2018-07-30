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

require conf/distro/include/yocto-uninative.inc

# The local fetcher (file://) doesn't verify checksum, which means that there
# is no error when yocto-uninative.inc is updated, this is not what we need.
# Put checksum into UNINATIVE_URL, and move the tarball into a directory named
# by checksum, so that we will get errors when it is updated.
#
UNINATIVE_URL = "file://${LAYER_PATH_wrlinux}/files/uninative-tarballs/${@d.getVarFlag('UNINATIVE_CHECKSUM', '${BUILD_ARCH}')}/"
