#
# Copyright (C) 2012 Wind River Systems, Inc.
#
DESCRIPTION = "An image with Sato support."

LICENSE = "MIT"

# we just extend glibc-std
#
require recipes-base/images/wrlinux-image-std.bb

# override PR in glibc-std
#
PR = "r1"

def base_matches(variable, pattern, truevalue, falsevalue, d):
    import re

    val = d.getVar(variable, True)
    if not val:
        return falsevalue

    match_re = re.compile(pattern)
    if match_re.match(val):
        return truevalue
    return falsevalue

IMAGE_FEATURES += "x11-base x11-sato"


# modify inittab in the image so we boot to a desktop
#
ROOTFS_POSTPROCESS_COMMAND += "sato_image_pp ; "

sato_image_pp () {
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','false','true',d)}; then
        bbnote "SATO - modifying default runlevel"
        sed -i -e "s/^id:.:/id:5:/" ${IMAGE_ROOTFS}/etc/inittab
    fi
}

