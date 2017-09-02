#
# Copyright (C) 2014 Wind River Systems, Inc.
#

# The graphics packages in packagegroup-self-hosted-graphics
# are for Build Appliance usage in oe-core which are not
# needed in our self-hosted feature.
# So drop the graphics packagegroup.
PACKAGES_remove = "packagegroup-self-hosted-graphics"
RDEPENDS_packagegroup-self-hosted_remove = "packagegroup-self-hosted-graphics"
