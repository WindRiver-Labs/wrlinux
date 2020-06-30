ROOTFS_POSTPROCESS_COMMAND += "\
    ${@bb.utils.contains('IMAGE_ENABLE_CONTAINER', '1', 'dnf_blacklist_systemd;', '', d)} \
"

python dnf_blacklist_systemd () {
    import configparser

    rootfs = d.getVar('IMAGE_ROOTFS')
    dnf_conf = rootfs + os.path.join(d.getVar('sysconfdir'), 'dnf/dnf.conf')

    config = configparser.ConfigParser()
    config.read(dnf_conf)

    exclude = config.get('main', 'exclude', fallback='')

    if 'systemd*' not in exclude:
        if exclude:
            exclude += ' systemd*'
        else:
            exclude = 'systemd*'

    config.set('main', 'exclude', exclude)

    with open(dnf_conf, 'w') as f:
        config.write(f, space_around_delimiters=False)
}
