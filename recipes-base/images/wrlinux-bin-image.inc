#
# Copyright (C) 2021 Wind River Systems, Inc.
#

LICENSE = "MIT"

CONTAINER_CORE_BOOT ?= " \
    base-files \
    base-passwd \
    ${VIRTUAL-RUNTIME_update-alternatives} \
"

# Only need tar.bz2 for container image
IMAGE_FSTYPES_remove = " \
    ${@bb.utils.contains('IMAGE_ENABLE_CONTAINER', '1', 'live wic wic.bmap ostreepush otaimg', '', d)} \
"

# No bsp packages for container
python () {
    if bb.utils.to_boolean(d.getVar('IMAGE_ENABLE_CONTAINER')):
        d.setVar('WRTEMPLATE_CONF_WRIMAGE_MACH', 'wrlnoimage_mach.inc')
    else:
        d.appendVar('IMAGE_FEATURES', ' wr-bsps')
        d.appendVar('IMAGE_FEATURES', ' x11-base')
}

IMAGE_FEATURES += "package-management empty-root-password"

inherit wrlinux-image

python (){
    bbincluded = (d.getVar('BBINCLUDED') or '').split()
    skip = '/wrlinux-bin-image.conf'
    for i in bbincluded:
        if i.endswith(skip):
            skip = ''
            break
    if skip:
        raise bb.parse.SkipRecipe("This recipe is highly customized for gen-image, cannot be used for any other cases")
}
