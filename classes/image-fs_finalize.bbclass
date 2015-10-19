#
# Copyright (C) 2012 - 2014 Wind River Systems, Inc.
#
# Implement routines to help make late (post rootfs) changes to the
# constructed filesystem image.
#
# Based on WR Linux 4.x
#
# This requires a version of RPM (rpm-native) that supports lua
# scriptiong.
#
# Configuration files belong in: TOPDIR/conf/
#
# such as: TOPDIR/conf/changelist.xml
#
# such as: TOPDIR/conf/fs_final00.sh
#          TOPDIR/conf/fs_final01.sh
#
WRL_CHANGELIST_PATH ?= "${TOPDIR}/conf"
WRL_FS_FINAL_PATH   ?= "${TOPDIR}/conf"

python() {
	fs_final_uris = "\n"
	for dir in (d.getVar('WRL_FS_FINAL_PATH', True) or '').split():
		if os.path.exists(dir) == False:
			continue
		for f in os.listdir(dir):
			if f.startswith('fs_final') and f.endswith('.sh'):
				fs_final_uris += "file://%s\n" % os.path.join(dir, f)
	d.appendVar('SRC_URI', fs_final_uris)
}


wrl_fs_local_pkg() {
	smart --data-dir=${IMAGE_ROOTFS}/var/lib/smart config --set rpm-force=1
	smart --data-dir=${IMAGE_ROOTFS}/var/lib/smart reinstall -y fs-local-pkg
}

wrl_fs_final_run() {
	logpath=`dirname ${BB_LOGFILE}`
	if [ -n "${WRL_FS_FINAL_PATH}" ]; then
	  count=0
	  for wrl_path in ${WRL_FS_FINAL_PATH}; do
	    echo "Checking for ${wrl_path}/fs_final*.sh"
	    for i in `ls ${wrl_path}/fs_final*.sh 2>/dev/null` ; do
	      if [ -f $i ]; then
			# Store symlink for later debugging if necessary
			targetcount=`printf '%.4d' $count`
			ln -s $i ${logpath}/fs_final-${targetcount}.sh.${PID}
			count=`expr $count + 1`

			export TOPDIR="${TOPDIR}"
			export TARGET_ARCH="${TARGET_ARCH}"
			export TARGET_VENDOR="${TARGET_VENDOR}"
			export TARGET_OS="${TARGET_OS}"
			export IMAGE_ROOTFS="${IMAGE_ROOTFS}"
			export WORKDIR="${WORKDIR}"
			export IMAGE_PKGTYPE="${IMAGE_PKGTYPE}"
			echo "Running fs_final.sh script ($targetcount) $i"
			(cd $IMAGE_ROOTFS ; sh $i)
	      fi
	    done
	  done
	fi

	# remove /etc/rpm and /var/lib/rpm if /usr/bin/rpm does not exist
	if [ -e "${IMAGE_ROOTFS}/usr/bin/rpm" ]; then
		echo "/usr/bin/rpm exists!"
	else
		echo "/usr/bin/rpm does not exist!"
		if [ -d ${IMAGE_ROOTFS}/etc/rpm ]; then
			t="${T}/saved_rpmlib/etc/rpm"
			rm -fr $t
			mkdir -p $t
			mv ${IMAGE_ROOTFS}/etc/rpm $t
			rm -rf ${IMAGE_ROOTFS}/etc/rpm
		fi
	fi 

	# Handle changelist.xml after fs_final.sh to acquire changes/appends to etc files 
	if [ -n "${WRL_CHANGELIST_PATH}" ]; then
	  count=0
	  for wrl_path in ${WRL_CHANGELIST_PATH}; do
	    echo "Checking for ${wrl_path}/changelist.xml"
	    if  [ -s ${wrl_path}/changelist.xml ]; then
		# Store symlink for later debugging if necessary
		targetcount=`printf '%.4d' $count`
		count=`expr $count + 1`
		ln -s ${wrl_path}/changelist.xml ${logpath}/changelist-${targetcount}.xml.${PID}

		echo "Running filesystem change script (${targetcount}) ${wrl_path}/changelist.xml"

		export TOP_BUILD_DIR="${wrl_path}"
		export EXPORT_DIST_DIR="${IMAGE_ROOTFS}"
		changelist=`which fs_changelist.lua 2>/dev/null`
		if [ -e "${changelist}" ]; then
			rpm --eval "%{lua: dofile(\"${changelist}\")} "
		else
			echo "ERROR: Unable to find fs_changelist.lua"
		fi
	    fi
	  done
	fi
}

ROOTFS_POSTINSTALL_COMMAND += "${@base_contains('IMAGE_INSTALL', 'fs-local-pkg', 'wrl_fs_local_pkg ;', '', d)}"
ROOTFS_POSTPROCESS_COMMAND += "wrl_fs_final_run ;"
