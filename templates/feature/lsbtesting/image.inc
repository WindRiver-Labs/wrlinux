#
# Copyright (C) 2013 - 2016 Wind River Systems, Inc.
#

# Some recipes in oe-core contain this distro override
# flag to enable extra configuration options to achieve
# LSB compliance.

# Add wr-lsbtest task from the the new glibc-std task lists
IMAGE_FEATURES += "wr-lsbtest"

# Add image features from oe-core that are related to LSB
# Note: those have now been renamed to wr-core-* instead
# of core-*

IMAGE_FEATURES += "wr-core-lsb-more wr-core-lsb-graphics-plus"

# add missing packages into build as required by LSB

# Misc libraries and packages
IMAGE_INSTALL += "libxi"
IMAGE_INSTALL += "libglu"
IMAGE_INSTALL += "libjpeg-turbo libjpeg-turbo-dev"
IMAGE_INSTALL += "gdk-pixbuf gdk-pixbuf-dev"
IMAGE_INSTALL += "foomatic-filters cups ghostscript"
IMAGE_INSTALL += "cups-lib cups-libimage"
IMAGE_INSTALL += "xdg-utils atk gtk+"
IMAGE_INSTALL += "gdk-pixbuf-loader-png"
IMAGE_INSTALL += "gdk-pixbuf-loader-jpeg"
IMAGE_INSTALL += "gdk-pixbuf-loader-gif"
IMAGE_INSTALL += "gdk-pixbuf-loader-xpm"
IMAGE_INSTALL += "shared-mime-info"
IMAGE_INSTALL += "liburi-perl"
IMAGE_INSTALL += "libxml2 libxml2-dev"
IMAGE_INSTALL += "shadow"
IMAGE_INSTALL += "lsbinitscripts"
IMAGE_INSTALL += "libxtst"
IMAGE_INSTALL += "perl-dev perl-doc"
IMAGE_INSTALL += "libclass-isa-perl"
IMAGE_INSTALL += "libenv-perl"
IMAGE_INSTALL += "libdumpvalue-perl"
IMAGE_INSTALL += "libfile-checktree-perl"
IMAGE_INSTALL += "libi18n-collate-perl"
IMAGE_INSTALL += "libpod-plainer-perl"
IMAGE_INSTALL += "libgcc"
IMAGE_INSTALL += "libpam"
IMAGE_INSTALL += "fontconfig-utils"

# packages that were dropped from the old glibc-std.
# We need them here to preserve LSB testing sanity.
IMAGE_INSTALL += "binutils"
IMAGE_INSTALL += "byacc"
IMAGE_INSTALL += "chkconfig"
IMAGE_INSTALL += "gettext"
IMAGE_INSTALL += "libaio"
IMAGE_INSTALL += "libassuan"
IMAGE_INSTALL += "libgettextlib"
IMAGE_INSTALL += "libgettextsrc"
IMAGE_INSTALL += "libksba"
IMAGE_INSTALL += "libproxy"
IMAGE_INSTALL += "libuser"
IMAGE_INSTALL += "libxml2"
#IMAGE_INSTALL += "libzypp"
IMAGE_INSTALL += "lighttpd"
IMAGE_INSTALL += "lighttpd-module-access"
IMAGE_INSTALL += "lighttpd-module-accesslog"
IMAGE_INSTALL += "lighttpd-module-dirlisting"
IMAGE_INSTALL += "lighttpd-module-indexfile"
IMAGE_INSTALL += "lighttpd-module-staticfile"
IMAGE_INSTALL += "m4"
IMAGE_INSTALL += "make"
IMAGE_INSTALL += "makedevs"
IMAGE_INSTALL += "gettext-runtime"
IMAGE_INSTALL += "openssh"
IMAGE_INSTALL += "patch"
IMAGE_INSTALL += "pax"
IMAGE_INSTALL += "pcmciautils"
IMAGE_INSTALL += "perl-module-encode-kr"
IMAGE_INSTALL += "python-dbus"
IMAGE_INSTALL += "rpcbind"
IMAGE_INSTALL += "rpm-build"
IMAGE_INSTALL += "rpm-common"
IMAGE_INSTALL += "sudo"
IMAGE_INSTALL += "tcp-wrappers"
IMAGE_INSTALL += "util-linux-uuidgen"
IMAGE_INSTALL += "libpng12"
IMAGE_INSTALL += "nss"
IMAGE_INSTALL += "nspr"
