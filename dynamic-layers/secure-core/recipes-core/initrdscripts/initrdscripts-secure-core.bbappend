#
# Copyright (C) 2018 Wind River Systems, Inc.
#

require ${@bb.utils.contains('DISTRO_FEATURES', 'efi-secure-boot', 'wr-initrdscripts-secure-core.inc', '', d)}
