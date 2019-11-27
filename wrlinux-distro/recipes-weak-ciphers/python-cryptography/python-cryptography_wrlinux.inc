#
# Copyright (C) 2017 Wind River Systems, Inc.
#

inherit features_check

CONFLICT_DISTRO_FEATURES_append = " openssl-no-weak-ciphers"
