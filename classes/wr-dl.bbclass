# Copyright (C) 2013 Wind River Systems, Inc.
# Common functions that are used for download caching

# This setting and function are used to group the items in the DL_DIR by
# layer.  This will assist in organizing the components into the correct dl
# cache directory.

DL_DIR .= "/${@wrl_downloaddir(d) or ""}"
def wrl_downloaddir(d):
    recipe = d.getVar("FILE", True) or ""
    for collection in (d.getVar("BBFILE_COLLECTIONS", True) or "").split():
        pattern = (d.getVar("BBFILE_PATTERN_%s" % (collection), True) or "")[1:]
        if pattern and recipe.startswith(pattern):
            return collection
    return None

