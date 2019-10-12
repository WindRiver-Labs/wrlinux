#
# Copyright (C) 2012, 2017, 2019 Wind River Systems, Inc.
#

POLICY_NAME = "wr-minimum"

include refpolicy-targeted_wr.inc

SRC_URI += "file://wr-policy-minimum-fix-avc-denials.patch \
           "
