# We need to change the SRC_URI to point to the bare git report in our layer.
# Otherwise the system may decide to fall back to the yoctoproject URL in some
# cases.  This would end up causing problems either due to incorrect SRCREV
# entries or by missing critical patches.
addhandler linux_yocto_rewrite_uri
linux_yocto_rewrite_uri[eventmask] = "bb.event.RecipePreFinalise"

python linux_yocto_rewrite_uri() {
    d = e.data

    layer_path="${LAYER_PATH_wrlinux}"

    if not d.getVar("LAYER_PATH_wrlinux"):
        bb.warn("Unable to replace SRC_URI paths with wrlinux layer paths.  LAYER_PATH_wrlinux is not defined.")
        return

    # We only care about the SRC_URI as it is defined right now.  We do NOT
    # want to expand it.
    src_uri=d.getVar("SRC_URI", False)

    # We need the -file- PV, not the actual PV...
    pv = d.expand("${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[1] or 'dev'}")

    # Replace the kernel URI.
    if os.path.exists("%s/git/linux-yocto.git" % (d.expand(layer_path))):
        src_uri = src_uri.replace("git://git.yoctoproject.org/linux-yocto.git", "git://${LAYER_PATH_wrlinux}/git/linux-yocto.git;protocol=file")

    if os.path.exists("%s/git/linux-yocto-dev.git" % (d.expand(layer_path))):
        src_uri = src_uri.replace("git://git.yoctoproject.org/linux-yocto-dev.git", "git://${LAYER_PATH_wrlinux}/git/linux-yocto-dev.git;protocol=file")

    if os.path.exists("%s/git/linux-yocto-%s.git" % (d.expand(layer_path), pv)):
        src_uri = src_uri.replace("git://git.yoctoproject.org/linux-yocto.git", "git://${LAYER_PATH_wrlinux}/git/linux-yocto-%s.git;protocol=file" % (pv))
        src_uri = src_uri.replace("git://git.yoctoproject.org/linux-yocto-%s.git" % (pv), "git://${LAYER_PATH_wrlinux}/git/linux-yocto-%s.git;protocol=file" % (pv))

    # Replace the kernel-cache URI.
    if os.path.exists("%s/git/yocto-kernel-cache.git" % d.expand(layer_path)):
        src_uri = src_uri.replace("git://git.yoctoproject.org/yocto-kernel-cache", "git://${LAYER_PATH_wrlinux}/git/yocto-kernel-cache.git;protocol=file")

        # The kernel-cache branch is hard coded by oe-core.  We need to make this adjutable.
        if d.getVar("KERNEL_CACHE_BRANCH_%s" % pv):
            import re
            src_uri = re.sub('(yocto-kernel-cache.*;branch=)([^;]*)', '\\1${KERNEL_CACHE_BRANCH_%s}' % pv, src_uri)

        if d.getVar("SRCREV_meta_%s" % pv):
            d.setVar("SRCREV_meta", d.getVar("SRCREV_meta_%s" % pv))

        if d.getVar("LINUX_VERSION_%s" % pv):
            d.setVar("LINUX_VERSION", d.getVar("LINUX_VERSION_%s" % pv))

    d.setVar("SRC_URI", src_uri)
}

#
# Verify that the defined KTYPE is in TARGET_SUPPORTED_KTYPES (if defined)
#
# This will help detect non-supported/non-tested configurations.
#
python () {
    kernel_type = d.getVar('LINUX_KERNEL_TYPE')
    supported_types = d.getVar('TARGET_SUPPORTED_KTYPES')

    # Skip checking, as supported types is blank
    if not supported_types or not kernel_type:
        return

    if kernel_type not in supported_types.split():
        raise bb.parse.SkipPackage('(version %s)  The defined LINUX_KERNEL_TYPE (%s) used by\
 this recipe is not in TARGET_SUPPORTED_KTYPES (%s).  To override add the type\
 to the supported list in your local.conf, such as:\
 TARGET_SUPPORTED_KTYPES_append = " %s"' % (d.getVar('PV'), kernel_type, supported_types, kernel_type))
}
