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
        src_uri = src_uri.replace("git://git.yoctoproject.org/linux-yocto.git", "git://%s/git/linux-yocto.git;protocol=file" % (layer_patch))

    if os.path.exists("%s/git/linux-yocto-%s.git" % (d.expand(layer_path), pv)):
        src_uri = src_uri.replace("git://git.yoctoproject.org/linux-yocto-%s.git" % (pv), "git://%s/git/linux-yocto-%s.git;protocol=file" % (layer_path, pv))

    # Replace the kernel-cache URI.
    if os.path.exists("%s/git/yocto-kernel-cache.git" % d.expand(layer_path)):
        src_uri = src_uri.replace("git://git.yoctoproject.org/yocto-kernel-cache", "git://%s/git/yocto-kernel-cache.git;protocol=file" % layer_path)

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
