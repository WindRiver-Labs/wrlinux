#
# Copyright (C) 2017 Wind River Systems, Inc.
#

WEAKCIPHERS = "${@bb.utils.contains('DISTRO_FEATURES', 'openssl-no-weak-ciphers', 'no-des no-md2 no-mdc2', '', d)}"
EXTRA_OECONF_append_class-target_osv-wrlinux = " ${WEAKCIPHERS}"
EXTRA_OECONF_append_class-nativesdk_osv-wrlinux = " ${WEAKCIPHERS}"
