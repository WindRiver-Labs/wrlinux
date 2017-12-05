#
# Copyright (C) 2012, 2017 Wind River Systems, Inc.
#

POLICY_NAME = "wr-minimum"

SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'file://refpolicy-minimum-reformat-upstream-patches.patch', '', d)}"

include refpolicy_wr.inc
