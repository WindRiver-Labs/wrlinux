copy_pkgdata() {
    dest=$1
    install -d $dest
    tar cfj $dest/pkgdata.tar.bz2 -C ${TMPDIR}/pkgdata ${MACHINE}
    (
        cd $dest;
        sha256sum pkgdata.tar.bz2 > pkgdata.tar.bz2.sha256sum
    )
}

do_copy_pkgdata_to_deploy_repo() {
    if ${@bb.utils.contains('DISTRO_FEATURES','lat','true','false',d)}; then
        for class in ${PACKAGE_CLASSES}; do
            class=`echo $class | sed -e 's/package_//'`
            deploydir=${DEPLOY_DIR}/$class
            copy_pkgdata $deploydir
            mv $deploydir/pkgdata.tar.bz2 $deploydir/.pkgdata.tar.bz2
            mv $deploydir/pkgdata.tar.bz2.sha256sum $deploydir/.pkgdata.tar.bz2.sha256sum
        done
    fi
}
addtask copy_pkgdata_to_deploy_repo after do_package_index before do_build

