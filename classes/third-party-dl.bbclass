#
# Copyright (C) 2020 Wind River Systems, Inc.
#
# Check and warn for the externally downloadable 3rd party components for
# the recipes which are in Wind River Linux but not supported.
#
# INHERIT += "third-party-dl"
#
# No warning for the following types:
# - WRLINUX_SUPPORTED_RECIPE_pn-<BPN> is None: Not in WRLinux
# - WRLINUX_SUPPORTED_RECIPE_pn-<BPN> = "1": Supported
# - WRLINUX_SUPPORTED_RECIPE_pn-<BPN> = "2": Ignored
#
# Only warn for:
# WRLINUX_SUPPORTED_RECIPE_pn-<BPN> = "0": In WRLinux, but not supported.
#
# EXTENDED_WRLINUX_RECIPES_LIST:
# Support extending wrlinux recipes list for some special layers
#
# Usage:
# EXTENDED_WRLINUX_RECIPES_LIST += "conf/layername-recipes-list.inc"
#

require conf/wrlinux-recipes-list.inc
EXTENDED_WRLINUX_RECIPES_LIST ?= ""
include ${EXTENDED_WRLINUX_RECIPES_LIST}

do_fetch[prefuncs] += "third_party_dl"

THIRD_PARTY_DL_CHECK ??= "1"
THIRD_PARTY_DL_MSG ?= "${PN} is not supported by Wind River Linux. Check 'Externally downloadable 3rd party components' in EULA for more information. You can set WRLINUX_SUPPORTED_RECIPE_pn-${BPN} = '2' to ignore the warning at your own risk"

third_party_dl[vardeps] += "WRLINUX_SUPPORTED_RECIPE_pn-${@d.getVar('BPN')} WRLINUX_SUPPORTED_RECIPE_pn-${@d.getVar('PN')}"

python third_party_dl() {
    tdc = d.getVar('THIRD_PARTY_DL_CHECK')
    if tdc not in ('0', '1'):
        bb.warn('THIRD_PARTY_DL_CHECK should be "0" or "1", but it is "%s"' % tdc)
        return

    if tdc == '0':
        bb.note('THIRD_PARTY_DL_CHECK is not set, skip the checking')
        return

    bpn = d.getVar('BPN')
    pn = d.getVar('PN')
    support_detail = d.getVar('WRLINUX_SUPPORTED_RECIPE_pn-%s' % pn) or d.getVar('WRLINUX_SUPPORTED_RECIPE_pn-%s' % bpn)
    if support_detail and '#' in support_detail:
        supported = support_detail.split("#")[0].strip()
    elif support_detail:
        supported = support_detail.strip()
    else:
        supported = None
    supported_values = (None, 0, 1)

    # No warning for the following types:
    # - Not in WRLinux
    # - Supported
    # - Ignored
    if supported in (None, '1', '2'):
        return
    # Only warn for the one which is in WRLinux, but not supported
    elif supported == "0":
        bb.warn(d.getVar('THIRD_PARTY_DL_MSG'))
    else:
        bb.warn('Unsupported vaule WRLINUX_SUPPORTED_RECIPE: %s, should be %s' % (supported, ' '.join(supported_values)))
}
