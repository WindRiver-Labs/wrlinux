# This handler is here to make sure that OVP layer is not built for non-x86 archs
addhandler compatible_ovp_archs
compatible_ovp_archs[eventmask] = "bb.event.ConfigParsed"

python compatible_ovp_archs() {
    import re
    compatible_host = '(x86_64|i.86).*-linux'
    this_host = d.getVar('HOST_SYS', True)
    if not re.match(compatible_host, this_host):
        bb.fatal("wr-ovp layer doesn't support non-x86 archs (incompatible host is %s)" % this_host)
}
