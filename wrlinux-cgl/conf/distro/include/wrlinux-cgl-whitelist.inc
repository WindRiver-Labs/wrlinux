#
# Copyright (C) 2016 Wind River Systems, Inc.
#
# Explicitly allow these recipes in wrlinux cgp
#
# This is based on the whitelist in layers/wrlinux,
# So we need to use _append to add extra packages here:
# PNWHITELIST_LAYERS_append = " layername"
#

# For meta-openembedded/meta-oe
PNWHITELIST_openembedded-layer_append = "\
    dlm \
"

# For meta-openembedded/meta-python
PNWHITELIST_meta-python_append = "\
    python-pyasn1 \
    python-cffi \
    python-pycparser \
    python-vcversioner \
"
