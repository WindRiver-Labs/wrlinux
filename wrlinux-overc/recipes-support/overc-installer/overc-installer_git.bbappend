# We need to change the SRC_URI to point to the bare git report in our layer.
# Otherwise the system may decide to fall back to the yoctoproject URL in some
# cases.  This would end up causing problems either due to incorrect SRCREV
# entries or by missing critical patches.
addhandler overc_installer_rewrite_uri
overc_installer_rewrite_uri[eventmask] = "bb.event.RecipePreFinalise"

SRCREV = "8d254edfe84070bb33663bd5db2ba54eb03700c0"

python overc_installer_rewrite_uri() {
    d = e.data

    if not d.getVar('LAYER_PATH_wrlinux-overc'):
        bb.warn("Unable to replace SRC_URI paths with wrlinux-overc layer paths.  LAYER_PATH_wrlinux-overc is not defined.")
        return

    layer_path="${LAYER_PATH_wrlinux-overc}"

    # We only care about the SRC_URI as it is defined right now.  We do NOT
    # want to expand it.
    src_uri=d.getVar("SRC_URI", False)

    # Replace the URI.
    if os.path.exists("%s/git/overc-installer.git" % (d.expand(layer_path))):
        src_uri = src_uri.replace("git://github.com/OverC/overc-installer.git;branch=master-oci", "git://${LAYER_PATH_wrlinux-overc}/git/overc-installer.git;branch=wr-10.19-20191106;protocol=file")

    d.setVar("SRC_URI", src_uri)
}
