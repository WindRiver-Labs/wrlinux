# Class that allows you to restrict the recipes brought from a layer to
# a specified list. This is similar in operation to blacklist.bbclass
# but note the difference in how PNWHITELIST is set - we don't use varflags
# here, the recipe name goes in the value and we use an override for the
# layer name (although this is not strictly required - you can have one
# PNWHITELIST value shared by all of the layers specified in
# PNWHITELIST_LAYERS). The layer name used here is actually the name that
# gets added to BBFILE_COLLECTIONS in the layer's layer.conf, which may
# differ from how the layer is otherwise known - e.g. meta-oe uses
# "openembedded-layer".
#
# INHERIT += "whitelist"
# PNWHITELIST_LAYERS = "layername"
# PNWHITELIST_layername = "recipe1 recipe2"
#
# If you would prefer to set a reason message other than the default, you
# can do so:
#
# PNWHITELIST_REASON_layername = "not supported by ${DISTRO}"

# Generic reason
PNWHITELIST_KEY_MSG ?= "To override, add to your local.conf:"
PNWHITELIST_CURRENT_LAYER ?= "${@bb.utils.get_file_layer(d.getVar('FILE'), d)}"
PNWHITELIST_REASON ?= "Not supported in this configuration by Wind River. ${PNWHITELIST_KEY_MSG} PNWHITELIST_${PNWHITELIST_CURRENT_LAYER} += '${BPN}'"
PNWHITELIST_REASON_ADDON ?= "You may also have to add: BB_NO_NETWORK = '0'"
PNWHITELIST ?= ""

python() {
    layer = bb.utils.get_file_layer(d.getVar('FILE'), d)
    if layer:
        layers = (d.getVar('PNWHITELIST_LAYERS') or '').split()
        if layer in layers:
            machine = d.getVar('MACHINE') or ''
            localdata = bb.data.createCopy(d)
            localdata.setVar('OVERRIDES', layer + ':' + machine)
            whitelist = (localdata.getVar('PNWHITELIST') or '').split()
            if not (d.getVar('PN') in whitelist or d.getVar('BPN') in whitelist):
                reason = localdata.getVar('PNWHITELIST_REASON')
                if not reason:
                    reason = 'not in PNWHITELIST for layer %s' % layer
                raise bb.parse.SkipRecipe(reason)
}

python whitelist_noprovider_handler() {
    import subprocess

    saved_distro_features = e.data.getVar('DISTRO_FEATURES')

    key_msg = d.getVar('PNWHITELIST_KEY_MSG')
    reason = str(e)
    if not key_msg in reason:
        return

    pn = e.getItem()
    bb.warn('%s is not whitelisted, figuring out PNWHITELIST...' % pn)

    cache_dir = d.getVar('CACHE')
    cache_file = os.path.join(cache_dir, 'bb_cache.dat')
    dump_cache_tool = os.path.join(d.getVar('COREBASE'), 'bitbake/contrib/dump_cache.py')
    cmd = [dump_cache_tool, '-m', 'pn,packages,provides,rprovides,appends,skipped,skipreason', cache_file]

    try:
        dumped_result = subprocess.check_output(cmd, stderr=subprocess.STDOUT).decode('utf-8')
    except subprocess.CalledProcessError as exec:
        bb.warn('%s' % exec)
        bb.warn('%s' % exec.output.decode('utf-8'))
        return

    def dump_cache(pn):
        bbfile = ''
        appends = ''
        skipped = ''
        skipreason = ''

        # Try to find the one which is in whitelist.
        for line in dumped_result.split('\n'):
            if not (line and '.bb' in line):
                continue

            line_list = line.split(': ')

            saved_pn = line_list[1]
            packages = eval(line_list[2])
            provides = eval(line_list[3])
            rprovides = eval(line_list[4])
            if not pn in ([saved_pn] + provides + rprovides + packages):
                continue

            bbfile = line_list[0]
            appends = eval(line_list[5])
            skipped = eval(line_list[6])
            skipreason = ': '.join(line_list[7:]).strip()
            if not skipped:
                break

        return bbfile, appends, skipped, skipreason

    def get_depends(bbfile, d):
        depends = ''
        if bbfile:
            localdata = bb.data.createCopy(d)
            bbfile = bb.cache.virtualfn2realfn(bbfile)[0]
            # Override DISTRO_FEATURES_NATIVE and DISTRO_FEATURES_NATIVESDK
            # since virtualfn2realfn is called.
            localdata.setVar('DISTRO_FEATURES', saved_distro_features)
            bb.cache.parse_recipe(localdata, bbfile, appends)
            bb.data.expandKeys(localdata)
            depends = localdata.getVar('DEPENDS')
            packages = localdata.getVar('PACKAGES')
            for pkg in packages.split():
                rdep_pkgs = localdata.getVar('RDEPENDS_%s' % pkg) or ''
                if rdep_pkgs:
                    depends += ' ' + rdep_pkgs

                rrec_pkgs = localdata.getVar('RRECOMMENDS_%s' % pkg) or ''
                if rrec_pkgs:
                    depends += ' ' + rrec_pkgs

            # Handle PACKAGECONFIG
            pkgconfigflags = localdata.getVarFlags("PACKAGECONFIG") or {}
            if pkgconfigflags:
                pkgconfig = (localdata.getVar('PACKAGECONFIG') or "").split()
                for flag, flagval in sorted(pkgconfigflags.items()):
                    items = flagval.split(",")
                    num = len(items)
                    if flag in pkgconfig:
                        if num >= 3 and items[2]:
                            depends += ' ' + items[2]
                        if num >= 4 and items[3]:
                            depends += ' ' + items[3]
                        if num >= 5 and items[4]:
                            depends += ' ' + items[4]

            # Handle Inter-Task Dependencies
            tasks = filter(lambda k: localdata.getVarFlag(k, "task"), d.keys())
            for task in tasks:
                taskVar = localdata.getVarFlags(task, False)
                if 'depends' in taskVar and ':' in taskVar["depends"]:
                    items = taskVar["depends"].split(':')[0]
                    if '${PV}' in items:
                        items = items.replace('${PV}', localdata.getVar('PV'))
                    depends += ' ' + items
        else:
            bb.warn('bbfile is empty')

        return ' '.join(bb.utils.explode_deps(depends))

    def get_templates(support_detail):
        pw_template = []
        if support_detail and '#' in support_detail:
            supported = support_detail.split("#")[0].strip()
            if supported and supported == '1':
                pw_template += support_detail.split("#")[1].strip().split()
        return pw_template

    # This is only a helper, so catch all possible errors, don't break
    # anything when there are unexpected errors.
    try:
        bbfile, appends, skipped, skipreason = dump_cache(pn)
        depends = get_depends(bbfile, d)

        add_lines = []
        pw_templates = []
        support_detail = d.getVar('WRLINUX_SUPPORTED_RECIPE_pn-%s' % pn)
        pw_templates += get_templates(support_detail)
        checked = set(d.getVar('ASSUME_PROVIDED').split())
        next = set(depends.split())
        counter = 0
        while next:
            if counter > 100:
                # Something must be wrong, just break out
                bb.error("Too many loops when calculating PNWHITELIST!")
                break
            new = set()
            for dep in next:
                if dep in checked:
                    continue
                checked.add(dep)
                bbfile, appends, skipped, skipreason = dump_cache(dep)
                if skipped and key_msg in skipreason:
                    add_line = skipreason.split(key_msg)[1].strip()
                    if not add_line in add_lines:
                        add_lines.append(add_line)
                    new.add(dep)
                    depends = get_depends(bbfile, d)
                    if depends:
                        new |= set(depends.split())
            new -= checked
            next = new
            counter += 1

        e_reasons = set(e._reasons)
        msg_prefix = ' '.join(e_reasons).split('%s ' % key_msg)[0] + key_msg
        msg_suffix = ' '.join(e_reasons).split('%s ' % key_msg)[1]
        if not msg_suffix in add_lines:
            add_lines.append(msg_suffix)
        add_lines.sort()
        pw_templates.sort()
        addon = d.getVar('PNWHITELIST_REASON_ADDON')
        if addon:
            add_lines.append('\n%s' % addon)
        if pw_templates:
            template_message = "\nOr consider using one of the following template(s):"
            for temp in pw_templates:
                template_message += "\nWRTEMPLATE += \"%s\"" % temp
            e._reasons = [msg_prefix] + add_lines + [template_message]
        else:
            e._reasons = [msg_prefix] + add_lines
    except Exception as esc:
        bb.error('whitelist_noprovider_handler() failed: %s' % esc)
}

addhandler whitelist_noprovider_handler
whitelist_noprovider_handler[eventmask] = "bb.event.NoProvider"
