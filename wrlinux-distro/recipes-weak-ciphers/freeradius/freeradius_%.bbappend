#
# Copyright (C) 2017 Wind River Systems, Inc.
#

PACKAGECONFIG_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'no-weak-ciphers', '', d)}"

PACKAGECONFIG[no-weak-ciphers] = "--without-openssl --without-rlm_eap_fast --without-rlm_eap_pwd,--with-openssl --with-rlm_eap_fast --with-rlm_eap_pwd"
DEPENDS_remove = "${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'openssl', '', d)}"
