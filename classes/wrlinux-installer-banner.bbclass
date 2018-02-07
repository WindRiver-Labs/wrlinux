target_build_msg =  "The meta-anaconda layer has been included, and the \
current build is a regular target build. After it is finished, create \
a new installer build with DISTRO = 'wrlinux-installer', \
INSTALLER_TARGET_BUILD = '<target-build-topdir>|<target-build-image>' \
and INSTALLER_TARGET_IMAGE = '<target-image-pn>' in local.conf"

target_build_warnmsg = "WARNING: The meta-anaconda layer has been included, \
and the current build is a regular target build. It requires to enable \
feature/installer-support template. Add option \
--templates=feature/installer-support to setup.sh, or set WRTEMPLATE += \
'feature/installer-support' in local.conf"

installer_build_msg =  "The meta-anaconda layer has been included, and the \
current build is a installer build, if set INSTALLER_TARGET_BUILD = \
'<target-build-topdir>', and INSTALLER_TARGET_IMAGE = '<target-image-pn>' \
the installer is to do RPMs install; if set INSTALLER_TARGET_BUILD = \
'<target-build-image>', the installer is to do image copy install."

def get_installer_banner(d):
    if d.getVar('DISTRO',True) == 'wrlinux-installer':
        return d.getVar('installer_build_msg', True)
    elif "feature/installer-support" in d.getVar("WRTEMPLATE", True).split():
        return d.getVar('target_build_msg', True)
    else:
        return d.getVar('target_build_warnmsg', True)

CONFIG_BANNER[installer] = "${@get_installer_banner(d)}"
