#
# Copyright (C) 2018 Wind River Systems, Inc.
#

PACKAGECONFIG_remove_osv-wrlinux = "${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'openssl', '', d)}"
