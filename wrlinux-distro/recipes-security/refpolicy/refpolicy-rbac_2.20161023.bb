#
# Copyright (C) 2012, 2017 Wind River Systems, Inc.
#
SUMMARY = "RBAC variants of the SELinux policy"
LICENSE = "MIT"
DESCRIPTION = "\
The reference policy for SELinux built with custom RBAC features. \
Since the Role-Based Access Control (RBAC) security model is already a \
part of SELinux, this is just a example for security administrators to \
create custom RBAC features. "

POLICY_NAME = "wr-rbac"
POLICY_TYPE = "mcs"

include recipes-security/refpolicy/refpolicy_${PV}.inc
include refpolicy_wr.inc

SRC_URI += "file://refpolicy-rbac-Implement-roles-capabilities.patch \
            file://refpolicy-rbac-Define-default-role-type-pairs.patch \
            file://refpolicy-rbac-Define-roles-in-kernel.te.patch \
            file://refpolicy-rbac-Define-SELinux-users.patch \
            file://refpolicy-rbac-fix-install-errors.patch \
           "
