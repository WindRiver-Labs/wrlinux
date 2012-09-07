# Implement a routine that adds the referenced debuginfo (-dbg) files to a
# parallel filesystem tarball to aid in remote debugging.
#
# Note, this parallel filesystem is likely not functional by itsel.
#

rpm_collect_debuginfo_files() {
   if [ "${IMAGE_GEN_DEBUGFS}" = "1" ]; then
	echo "Generating a companion debug filesystem..."

	echo "  Creating a backup of the image into image-dbg"
	rm -rf ${INSTALL_ROOTFS_RPM}-dbg
	mkdir -p ${INSTALL_ROOTFS_RPM}-dbg
	cp -a ${INSTALL_ROOTFS_RPM}/install ${INSTALL_ROOTFS_RPM}-dbg/.
	mkdir -p ${INSTALL_ROOTFS_RPM}-dbg/etc/
	cp -a ${INSTALL_ROOTFS_RPM}/etc/rpm ${INSTALL_ROOTFS_RPM}-dbg/etc/.
	mkdir -p ${INSTALL_ROOTFS_RPM}-dbg/var/lib/
	cp -a ${INSTALL_ROOTFS_RPM}/var/lib/rpm ${INSTALL_ROOTFS_RPM}-dbg/var/lib/.

	INSTALL_ROOTFS_RPM_BAK=${INSTALL_ROOTFS_RPM}
	export INSTALL_ROOTFS_RPM=${INSTALL_ROOTFS_RPM}-dbg

	# Move of the scriptlet helper out of the way, we don't want it...
	mv ${WORKDIR}/scriptlet_wrapper ${WORKDIR}/scriptlet_wrapper.bak

	echo "#! /bin/bash" > ${WORKDIR}/scriptlet_wrapper
	chmod +x ${WORKDIR}/scriptlet_wrapper

	rootfs_install_complementary '*-dbg'

	# Cleanup the various temp files
	for file in ${INSTALL_ROOTFS_RPM}/install/*.manifest
	do
	   base=`basename $file`
	   cp $file ${T}/dbg-$base || true
	done
	rm -rf ${INSTALL_ROOTFS_RPM}/install

	# Restore the helper
	mv ${WORKDIR}/scriptlet_wrapper.bak ${WORKDIR}/scriptlet_wrapper

	# Restore the variable for any other users...
	export INSTALL_ROOTFS_RPM=${INSTALL_ROOTFS_RPM_BAK}
   fi
}

RPM_POSTPROCESS_COMMANDS_append += "rpm_collect_debuginfo_files ;"

ipk_collect_debuginfo_files() {
   if [ "${IMAGE_GEN_DEBUGFS}" = "1" ]; then
	echo "Generating a companion debug filesystem..."

	echo "  Creating a backup of the image into image-dbg"
	rm -rf ${INSTALL_ROOTFS_IPK}-dbg
	mkdir -p ${INSTALL_ROOTFS_IPK}-dbg
	if [ -d ${INSTALL_ROOTFS_IPK}/etc/opkg ]; then
	   mkdir -p ${INSTALL_ROOTFS_IPK}-dbg/etc
	   cp -a ${INSTALL_ROOTFS_IPK}/etc/opkg ${INSTALL_ROOTFS_IPK}-dbg/etc/.
	fi
	mkdir -p ${INSTALL_ROOTFS_IPK}-dbg/var/lib
	cp -a ${INSTALL_ROOTFS_IPK}/var/lib/opkg ${INSTALL_ROOTFS_IPK}-dbg/var/lib/.

	INSTALL_ROOTFS_IPK_BAK=${INSTALL_ROOTFS_IPK}
	export INSTALL_ROOTFS_IPK=${INSTALL_ROOTFS_IPK}-dbg

	rootfs_install_complementary '*-dbg'

	# Restore the variable for any other users...
	export INSTALL_ROOTFS_IPK=${INSTALL_ROOTFS_IPK_BAK}
   fi
}

OPKG_POSTPROCESS_COMMANDS_append += "ipk_collect_debuginfo_files ;"

deb_collect_debuginfo_files() {
   if [ "${IMAGE_GEN_DEBUGFS}" = "1" ]; then
	echo "Generating a companion debug filesystem..."

	echo "  Creating a backup of the image into image-dbg"
	rm -rf ${INSTALL_ROOTFS_DEB}-dbg
	mkdir -p ${INSTALL_ROOTFS_DEB}-dbg
	mkdir -p ${INSTALL_ROOTFS_DEB}-dbg/var/lib
	cp -a ${INSTALL_ROOTFS_DEB}/var/lib/dpkg ${INSTALL_ROOTFS_DEB}-dbg/var/lib/.

	INSTALL_ROOTFS_DEB_BAK=${INSTALL_ROOTFS_DEB}
	export INSTALL_ROOTFS_DEB=${INSTALL_ROOTFS_DEB}-dbg

	APT_CONFIG_BAK=${APT_CONFIG}
	export APT_CONFIG=`echo ${APT_CONFIG} | sed "s,${INSTALL_ROOTFS_DEB_BAK},${INSTALL_ROOTFS_DEB},g"`

	sed -i "s,${INSTALL_ROOTFS_DEB_BAK},${INSTALL_ROOTFS_DEB},g" \
		${APT_CONFIG}

	rootfs_install_complementary '*-dbg'

	# Restore the variable for any other users...
	export APT_CONFIG=${APT_CONFIG_BAK}
	export INSTALL_ROOTFS_DEB=${INSTALL_ROOTFS_DEB_BAK}
   fi
}

DEB_POSTPROCESS_COMMANDS_append += "deb_collect_debuginfo_files ;"

tar_debuginfo_files() {
   # Remove link name
   if [ -n "${IMAGE_LINK_NAME}" ]; then
	rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}-dbg.tar.bz2
   fi

   if [ "${IMAGE_GEN_DEBUGFS}" = "1" ]; then
	echo "taring and compressing companion debug filesystem..."
	(cd ${IMAGE_ROOTFS}-dbg && tar -cvf ${DEPLOY_DIR_IMAGE}/${IMAGE_NAME}-dbg.rootfs.tar . && \
	 bzip2 -f ${DEPLOY_DIR_IMAGE}/${IMAGE_NAME}-dbg.rootfs.tar)

	# Generate deploy link name
	if [ -n "${IMAGE_LINK_NAME}" ]; then
	   ln -s ${IMAGE_NAME}-dbg.rootfs.tar.bz2 ${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}-dbg.tar.bz2
	fi
   fi
}

IMAGE_POSTPROCESS_COMMAND_append += "tar_debuginfo_files ;"
