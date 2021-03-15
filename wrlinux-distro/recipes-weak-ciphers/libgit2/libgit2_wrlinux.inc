#
# Copyright (C) 2021 Wind River Systems, Inc.
#

NONTLMCLIENT = "${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', '-DUSE_NTLMCLIENT=OFF', '', d)}"
EXTRA_OECMAKE_append_osv-wrlinux = " ${NONTLMCLIENT}"
