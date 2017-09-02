#
# Copyright (C) 2012 Wind River Systems, Inc.
#
DESCRIPTION = "A foundational tiny image that boots to a console."

LICENSE = "MIT"

# We override what gets set in core-image.bbclass
#
IMAGE_INSTALL = "\
    packagegroup-wr-tiny \
    "

inherit wrlinux-image

# The following is a specialized version of code in distro_features_check.bbclass.
# We include it here in order to provide a more meaningful error message.
#
python () {
    distro_features = (d.getVar('DISTRO_FEATURES') or "").split()

    # allow for multiple conflicts
    conflict_distro_features = "systemd"
    conflict_distro_features = conflict_distro_features.split()
    for f in conflict_distro_features:
        if f in distro_features:
            raise bb.parse.SkipPackage("This recipe is not compatible with '%s'.  Disable it in local.conf." % f)
}
