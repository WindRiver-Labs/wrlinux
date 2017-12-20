# For Wind River Linux we want to override the QEMU BSP machine SRCREV values
# to AUTOREV, this ensures that the -KBRANCH- value will be used, and the
# latest commit in that branch will always be used.
SRCREV_machine_qemuarm    = "${AUTOREV}"
SRCREV_machine_qemuarm64  = "${AUTOREV}"
SRCREV_machine_qemumips   = "${AUTOREV}"
SRCREV_machine_qemuppc    = "${AUTOREV}"
SRCREV_machine_qemux86    = "${AUTOREV}"
SRCREV_machine_qemux86-64 = "${AUTOREV}"
SRCREV_machine_qemumips64 = "${AUTOREV}"

# Default the system to AUTOREV for any other BSPs not already defined.  This
# is done for the same reason as the QEMU machines above.
SRCREV_machine ?= "${AUTOREV}"

SRCREV_meta = "${AUTOREV}"

# We need to change the SRC_URI to point to our layer.  Otherwise the system
# may decide to fall back to the yoctoproject URL in some cases.  This would
# end up causing problems either due to incorrect SRCREV entries or by missing
# critical patches.
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

    # Replace the kernel URI.
    src_uri = src_uri.replace("git://git.yoctoproject.org/linux-yocto-4.12.git", "git://%s/git/linux-yocto-4.12.git;protocol=file" % layer_path)

    # Replace the kernel-cache URI.
    src_uri = src_uri.replace("git://git.yoctoproject.org/yocto-kernel-cache", "git://%s/git/yocto-kernel-cache;protocol=file" % layer_path)

    # The kernel-cache branch is hard coded by oe-core.  We need to make this adjutable.
    if d.getVar("KERNEL_CACHE_BRANCH"):
        src_uri = src_uri.replace("branch=yocto-4.12;", "branch=${KERNEL_CACHE_BRANCH};")

    d.setVar("SRC_URI", src_uri)
}

LINUX_VERSION = "4.12.18"
