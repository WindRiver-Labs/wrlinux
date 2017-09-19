#
# Copyright (C) 2017 Wind River Systems, Inc.
#

EXTRA_OECONF_remove = "${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', '--with-ecdsa=yes', '', d)}"
EXTRA_OECONF_append = " --with-ecdsa=${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'no', 'yes', d)}"
