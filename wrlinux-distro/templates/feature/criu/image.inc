# Install CRIU userspace utility
IMAGE_INSTALL += ' ${@criu_supported_archs(["x86_64", "aarch64", "arm"], "criu", "", d)}'

def criu_supported_archs(checkarch, truevalue, falsevalue, d):
    """
    criu sets COMPATIBLE_HOST to x86_64, but no x86, so there would be
    errors when build with multilib, use
    IMAGE_INSTALL_append_x86-64 = "criu" doesn't work either since
    multilib.bbclass doesn't change DEFAULTTUNE for image recipe, and
    it's the way the system is designed, so use a function to fix the
    problem and it can be removed once criu supports both x86_64 and x86.
    """
    mlprefix =  d.getVar('MLPREFIX', True)
    if mlprefix:
        variant = d.getVar("BBEXTENDVARIANT", True)
        newtune = d.getVar("DEFAULTTUNE_" + "virtclass-multilib-" + variant, False)
        if newtune in checkarch:
            return truevalue
    elif d.getVar('TARGET_ARCH', True) in checkarch:
            return truevalue

    return falsevalue
