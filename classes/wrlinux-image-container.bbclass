inherit wrlinux-image

python rootfs_container_compatible() {
    excl_pkgs = ['kernel', 'kernel-base', 'kernel-vmlinux', 'kernel-image', 'kernel-alt-image', 'kernel-dev', 'kernel-modules']
    inst_pkgs = d.getVar("PACKAGE_INSTALL", True).split()

    for pkg in excl_pkgs:
        if pkg in inst_pkgs:
            inst_pkgs.remove(pkg)

    d.setVar("PACKAGE_INSTALL", ' '.join(inst_pkgs))
}
do_rootfs[prefuncs] += "rootfs_container_compatible"

