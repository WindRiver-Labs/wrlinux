# transfer "SECURITY_CFLAGS_pn-recipe = ..." to
# "SECURITY_CFLAGS_pn-mlib-recipe = ..." and
# transfer "SECURITY_CFLAGS_pn-recipe_powerpc = ..."
# to "SECURITY_CFLAGS_pn-mlib-recipe_powerpc = ..."

python transfer_security_cflags () {
    mlprefix = e.data.getVar('MLPREFIX', True)

    if mlprefix:
        pn = e.data.getVar('PN', True)
        bpn = e.data.getVar('BPN', True)
        cflags = e.data.getVar("SECURITY_CFLAGS_pn-%s" % bpn, True)
        if cflags is not None:
            e.data.setVar("SECURITY_CFLAGS_pn-%s" % pn, cflags)

        arch = e.data.getVar('HOST_ARCH', True)
        cflags = e.data.getVar("SECURITY_CFLAGS_pn-%s_%s" %(bpn, arch), True)
        if cflags is not None:
            e.data.setVar("SECURITY_CFLAGS_pn-%s_%s" %(pn, arch), cflags)
}

addhandler transfer_security_cflags
transfer_security_cflags[eventmask] = "bb.event.RecipeParsed"
