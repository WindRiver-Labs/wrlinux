# Template conf file to add demo packages.  The list is derived from
# wrlinux 4.3.  Note the commented packages, which do not exist
# in 5.0.
#

# The machine and the distro have to support alsa for us
# to include related packages.
#
IMAGE_INSTALL += "${@bb.utils.contains('COMBINED_FEATURES', 'alsa', 'packagegroup-base-alsa', '',d)}"
IMAGE_INSTALL += "bzip2"
IMAGE_INSTALL += "eject"
IMAGE_INSTALL += "expat"
IMAGE_INSTALL += "flex"
IMAGE_INSTALL += "libgcc"
IMAGE_INSTALL += "lighttpd"
IMAGE_INSTALL += "makedevs"
IMAGE_INSTALL += "ncurses"
IMAGE_INSTALL += "openssl"
IMAGE_INSTALL += "yaffs2-utils"
IMAGE_INSTALL += "zlib"

#   agent-proxy
#   boa
#   filesystem
#   net-snmp
#   setmixer
#   sox

