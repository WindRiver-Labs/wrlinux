#
# Copyright (C) 2020 Wind River Systems, Inc.
#
# Class that checks the externally downloadable 3rd party components.
#
# INHERIT += "third-party-dl"
# THIRD_PARTY_DL_IGNORED_RECIPES += "recipe1 recipe2"

require conf/wrlinux-recipes-list.inc

do_fetch[prefuncs] += "third_party_dl"

THIRD_PARTY_DL_CHECK ??= "1"
THIRD_PARTY_DL_IGNORED_RECIPES ?= ""
THIRD_PARTY_DL_MSG ?= "${PN} is not supported by Wind River. Check 'Externally downloadable 3rd party components' in EULA for more information."

python third_party_dl() {
    tdc = d.getVar('THIRD_PARTY_DL_CHECK')
    if tdc not in ('0', '1'):
        bb.warn('THIRD_PARTY_DL_CHECK should be "0" or "1", but it is "%s"' % tdc)
        return

    if tdc == '0':
        bb.note('THIRD_PARTY_DL_CHECK is not set, skip the checking')
        return

    bpn = d.getVar('BPN')
    supported_recipes = d.getVar('WRLINUX_SUPPORTED_RECIPES').split()
    all_recipes = d.getVar('WRLINUX_ALL_RECIPES').split()
    ignored_recipes = d.getVar('THIRD_PARTY_DL_IGNORED_RECIPES').split()

    if not bpn in (supported_recipes + ignored_recipes) and bpn in all_recipes:
        bb.warn(d.getVar('THIRD_PARTY_DL_MSG'))
        bb.warn('You can set THIRD_PARTY_DL_IGNORED_RECIPES += "%s" to ignore the warning at your own risk' % bpn)
}
