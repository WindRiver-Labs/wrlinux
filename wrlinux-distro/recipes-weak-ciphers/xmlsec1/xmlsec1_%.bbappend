#
# Copyright (C) 2017 Wind River Systems, Inc.
#

PACKAGECONFIG_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'no-weak-ciphers', '', d)}"
PACKAGECONFIG[no-weak-ciphers] = "--without-openssl,"
