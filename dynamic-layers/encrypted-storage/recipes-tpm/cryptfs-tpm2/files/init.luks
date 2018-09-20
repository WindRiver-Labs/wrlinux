#!/bin/sh

# BSD 2-clause "Simplified" License
#
# Copyright (c) 2016-2017, Wind River Systems, Inc.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1) Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# 2) Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# 3) Neither the name of Wind River Systems nor the names of its contributors
# may be used to endorse or promote products derived from this software
# without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# Author:
#        Lans Zhang <jia.zhang@windriver.com>
#        Yunguo Wei <yunguo.wei@windriver.com>
#

#
# Global constant settings
#

# The tmpfs filesystem used to temporarily place the
# passphrase file.
ROOT_LABEL=
FLUXDATA_LABEL=
FACTORY_BACKUP_LABEL="_b"
#This is assumed backup root label, and it might be changed later
BACKUP_ROOT_LABEL=

TMP_DIR="/tmp"
TMP_MNT="/tmpmnt"
TMP_MNT_ROOT="$TMP_MNT/${ROOT_LABEL}"
TMP_MNT_BACKUP_ROOT=
TMP_MNT_FLUXDATA=

# The prefix label for LUKS
LUKS_PREFIX_LABEL="luks_"

ROOT_IS_LUKS=0
BACKUP_ROOT_IS_LUKS=0
FLUXDATA_IS_LUKS=0

#
# Global variable settings
#

TPM_TIS_MODULE_LOADED=0
TPM_CRB_MODULE_LOADED=0
TPM_DEVICE=""
TPM_EVICT_OPT="-e"

#ROOT_DEVNAME=""
#FLUXDATA_DEVNAME=""

ROOT_RESTORE_DONE_INDICATIOR="/home/.luks.init.done"
ROOT_BACKUP_DIR="$TMP_DIR"
ROOT_BACKUP_FILE="rootfs.tgz"

MOUNT_FLAG="rw,noatime,iversion"

cmdline="`cat /proc/cmdline`"
for arg in $cmdline; do
    optarg=`expr "x$arg" : 'x[^=]*=\(.*\)'`

    case "$arg" in
    root=*)
        ROOT_LABEL="$optarg"
        ;;
    flux=*)
        FLUXDATA_LABEL="$optarg"
        ;;
    esac
done

LUKS_LABEL_TO_BE_CREATED="$(blkid -s LABEL | grep LABEL=\"${LUKS_PREFIX_LABEL} | awk -F: '{ print $2 }' | cut -f 2 -d "\"" |xargs)"

print_critical() {
    printf "\033[1;35m"
    echo "$@"
    printf "\033[0m"
}

print_error() {
    printf "\033[1;31m"
    echo "$@"
    printf "\033[0m"
}

print_warning() {
    printf "\033[1;33m"
    echo "$@"
    printf "\033[0m"
}

print_info() {
    printf "\033[1;32m"
    echo "$@"
    printf "\033[0m"
}

print_verbose() {
    printf "\033[1;36m"
    echo "$@"
    printf "\033[0m"
}

create_dir() {
    local dir="$1"

    if [ ! -d "$dir" ]; then
        mkdir -p "$dir" || return 1
    fi

    return 0
}

umount_dir() {
    local dir="$1"

    [ -z $dir ] && return 0

    mnt_point=$(mount |grep $1 | cut -f 3 -d " ")

    [ -z $mnt_point ] ||{ 
	#print_verbose "Umounting $mnt_point"
	umount $mnt_point
    }
}
detect_tpm_chip() {
    local ret_absent="$1"

    [ ! -e /sys/class/tpm ] && print_info "TPM subsystem is not enabled." && return 1

    depmod -a 2>/dev/null
    ! grep -q "^tpm_tis" /proc/modules && modprobe --quiet tpm_tis && TPM_TIS_MODULE_LOADED=1
    ! grep -q "^tpm_crb" /proc/modules && modprobe --quiet tpm_crb && TPM_CRB_MODULE_LOADED=1

    local tpm_devices=$(ls /sys/class/tpm)
    [ -z "$tpm_devices" ] && print_info "No TPM chip detected." && return 1

    local tpm_absent=1
    local name=""
    for name in $tpm_devices; do
        grep -q "TCG version: 1.2" "/sys/class/tpm/$name/device/caps" 2>/dev/null &&
            print_info "TPM 1.2 device $name is not supported." && break

        grep -q "TPM 2.0 Device" "/sys/class/tpm/$name/device/description" 2>/dev/null &&
            tpm_absent=0 && break

	grep -q "TPM 2.0 Device" "/sys/class/tpm/$name/device/firmware_node/description" 2>/dev/null &&
            tpm_absent=0 && break
    done

    [ $tpm_absent -eq 1 ] && print_info "No supported TPM device found." && return 1

    local name_in_dev="$name"
    # /dev/tpm is the alias of /dev/tpm0.
    [ "$name_in_dev" = "tpm0" ] && name_in_dev+=" tpm"

    local _name=""
    for _name in $name_in_dev; do
        [ -c "/dev/$_name" ] && break

        local major=$(cat "/sys/class/tpm/$name/dev" | cut -d ":" -f 1)
        local minor=$(cat "/sys/class/tpm/$name/dev" | cut -d ":" -f 2)
        ! mknod "/dev/$_name" c $major $minor &&
            print_error "Unable to create tpm device node $_name." && return 1

        TPM_DEVICE="/dev/$_name"

        break
    done

    [ -n "$ret_absent" ] && eval $ret_absent=$tpm_absent

    print_info "TPM device /dev/$_name detected."

    return 0
}

get_dev_from_label() {
    #print_verbose "Getting dev for LABEL=$1."
    blkid -s LABEL | grep LABEL=\"$1\" | awk -F: '{ print $1 }' 
}

luks_detect() {
    # return if no partition labeled as "luksxxx"
    [ -z "${LUKS_LABEL_TO_BE_CREATED}" ] && return 0

    # retrieve root_backup label
    if [ -n "${BACKUP_ROOT_LABEL}" ]; then
        echo ${LUKS_LABEL_TO_BE_CREATED} |grep ${BACKUP_ROOT_LABEL}
        [ $? = 0 ] || {
            # case for root_label="otaroot_b", we should set backup_root_label="otaroot"
            BACKUP_ROOT_LABEL=${BACKUP_ROOT_LABEL%"${FACTORY_BACKUP_LABEL}"}
        }
    fi

    for luks_label in ${LUKS_LABEL_TO_BE_CREATED}; do
	if [ "$luks_label" = "${LUKS_PREFIX_LABEL}${ROOT_LABEL}" ]; then
	    ROOT_IS_LUKS=1
	    continue
    	fi

	if [ "$luks_label" = "${LUKS_PREFIX_LABEL}${BACKUP_ROOT_LABEL}" -a -n "${BACKUP_ROOT_LABEL}" ]; then
	    BACKUP_ROOT_IS_LUKS=1
	    continue
	fi

	if [ "$luks_label" = "${LUKS_PREFIX_LABEL}${FLUXDATA_LABEL}" -a  -n "${FLUXDATA_LABEL}" ]; then
	    FLUXDATA_IS_LUKS=1
	    continue
	fi
    done
}

# create LUKS
_luks_create() {
    luks_label_name=$1
    label_name=${luks_label_name##*"${LUKS_PREFIX_LABEL}"}
    luks_rawdev_path=$(get_dev_from_label $luks_label_name)
    fs_type=`blkid -t LABEL="$luks_label_name" -s TYPE | awk -F: '{ print $2 }' | cut -f 2 -d "\""`

    existing_luks=$(blkid -s TYPE | grep crypto_LUKS | wc -l)
    if [ $existing_luks -ne 0 ]; then
	# do not evict previous keys if there is LUKS partition existing on the board
	TPM_EVICT_OPT=""
    fi

    # generate random seeds
    [ -e ${TMP_DIR}/rngd.pid ] || rngd -r /dev/urandom --pid ${TMP_DIR}/rngd.pid

    cmd="luks-setup.sh -f $TPM_EVICT_OPT -d ${luks_rawdev_path} -n ${LUKS_PREFIX_LABEL}${luks_rawdev_path##*/}"
    cmd="echo Y | $cmd"
    eval "$cmd"

    [ ! $? -eq 0 ] && {
	umount_dir ${TMP_MNT_ROOT}
       [ -n ${TMP_MNT_FLUXDATA} ] &&  umount_dir ${TMP_MNT_FLUXDATA}
        rm -rf $TMP_MNT
	luks_relabel_all
	exit 0
    }

    mkfs.${fs_type} /dev/mapper/${LUKS_PREFIX_LABEL}${luks_rawdev_path##*/} -L ${label_name}
    udevadm trigger && partprobe && sync

    return 0
    
}

# create LUKS for fluxdata
luks_create_fluxdata() {
    if [ $FLUXDATA_IS_LUKS -eq 1 ]; then
	_luks_create ${LUKS_PREFIX_LABEL}${FLUXDATA_LABEL}
	[ $? -eq 0 ] || return 1
    fi

    return 0 
}

# backup non-encrypted root partition on fluxdata partition
_luks_backup_root() {
    # map non-encrypted root
    _luks_mount_label ${LUKS_PREFIX_LABEL}${ROOT_LABEL} $TMP_MNT_ROOT || return 1

    [ -n "${FLUXDATA_LABEL}" ] && {
        _luks_mount_label ${FLUXDATA_LABEL} $TMP_MNT_FLUXDATA || return 1
    }

    print_verbose "Backing up root partition before creating LUKS"
    # backup rootfs on fluxdata partition
    cd ${TMP_MNT_ROOT}
    tar  cf - ./ -P --xattrs --xattrs-include=* | pv -s $(($(du -sk ./ | awk '{print $1}') * 1024)) | gzip > ${ROOT_BACKUP_DIR}/${ROOT_BACKUP_FILE}

    #print_verbose "Unmout non-encrypted root partition"
    cd / && umount_dir $TMP_MNT_ROOT && umount_dir ${ROOT_BACKUP_DIR}
}

_luks_restore_root() {

    _luks_mount_label ${ROOT_LABEL} $TMP_MNT_ROOT || return 1

    if [ -n "${BACKUP_ROOT_LABEL}" ]; then
        _luks_mount_label ${BACKUP_ROOT_LABEL} $TMP_MNT_BACKUP_ROOT || return 1
    fi

    if [ -n "${FLUXDATA_LABEL}" ]; then
        _luks_mount_label ${FLUXDATA_LABEL} $TMP_MNT_FLUXDATA || return 1
    fi

    print_verbose "Restoring root partition on LUKS"
    cd ${TMP_MNT_ROOT}
    # restore rootfs
    pv ${ROOT_BACKUP_DIR}/${ROOT_BACKUP_FILE} | tar xpzf  - --warning=no-timestamp --numeric-owner --xattrs --xattrs-include=* -C ./
    cd /  && touch $TMP_MNT_ROOT/${ROOT_RESTORE_DONE_INDICATIOR} && sync
    
    if [ -n "${BACKUP_ROOT_LABEL}" ]; then
        print_verbose "Restoring stand-by root partition on LUKS"
        cd ${TMP_MNT_BACKUP_ROOT}
        # restore rootfs
        pv ${TMP_MNT_FLUXDATA}/${ROOT_BACKUP_FILE} |  \
		tar xpzf  - --warning=no-timestamp --numeric-owner --xattrs --xattrs-include=* -C ./
        cd /  &&  touch $TMP_MNT_BACKUP_ROOT}/${ROOT_RESTORE_DONE_INDICATIOR} && sync

    fi

    rm -rf ${ROOT_BACKUP_DIR}/${ROOT_BACKUP_FILE} && \

    return 0
}

# this is to avoid power off during restoring root partition at first boot
luks_check_restore_root() {

    root_dev=$(get_dev_from_label ${ROOT_LABEL})

    # if root partition is not LUKS, no need to check
    [ -z $root_dev ] && return 1 || {
	echo $root_dev | grep -q /dev/mapper || return 0
    }

    # mount failed , return immediately
    _luks_mount_label ${ROOT_LABEL} $TMP_MNT_ROOT || return 1

    # ROOT_RESTORE_DONE_INDICATIOR means no need to restore
    [ -e $TMP_MNT_ROOT/${ROOT_RESTORE_DONE_INDICATIOR} ] &&  \
	    [ -e $TMP_MNT_BACKUP_ROOT/${ROOT_RESTORE_DONE_INDICATIOR} ] && \
	    return 0

    _luks_mount_label ${FLUXDATA_LABEL} $TMP_MNT_FLUXDATA || return 1
    # no ROOT_RESTORE_DONE_INDICATIOR and no ROOT_BACKUP_FILE: no need to restore
    [ ! -e ${TMP_MNT_FLUXDATA}/${ROOT_BACKUP_FILE} ] && return 0

    _luks_restore_root

    ret=$?

    sync && umount_dir $TMP_MNT_ROOT && umount_dir $TMP_MNT_BACKUP_ROOT && umount_dir $TMP_MNT_FLUXDATA

    return $ret
}

# LABEL=FLUXDATA is assumed to be ready at this moment
luks_create_root() {
    [ $ROOT_IS_LUKS -eq 0 ] && return 0
    
    _luks_backup_root || return 1

    print_verbose "Creating LUKS for root partition..."
    _luks_create ${LUKS_PREFIX_LABEL}${ROOT_LABEL} || return 1

    if [ -n "${BACKUP_ROOT_LABEL}" ]; then
        print_verbose "Creating LUKS for backup root partition..."
        _luks_create ${LUKS_PREFIX_LABEL}${BACKUP_ROOT_LABEL} || return 1
    fi

    _luks_restore_root || return 1

    return 0
}

# create LUKS for non-root|fluxdata partitions
luks_create_others() {
    [ -z "${LUKS_LABEL_TO_BE_CREATED}" ] && return 0

    for luks_label in ${LUKS_LABEL_TO_BE_CREATED}; do
	if [ "${luks_label}" == "${LUKS_PREFIX_LABEL}${ROOT_LABEL}" ] || \
		[ "${luks_label}" == "${LUKS_PREFIX_LABEL}${FLUXDATA_LABEL}" ] || \
		[ "${luks_label}" == "${LUKS_PREFIX_LABEL}${BACKUP_ROOT_LABEL}" ]; then
		continue
	fi
	print_verbose "Creating LUKS for LABEL=${luks_label}"

	_luks_create ${luks_label}

	#TODO: update /etc/fstab based on wic file
    done
}

luks_create() {

    [ $FLUXDATA_IS_LUKS -eq 1 ] && luks_create_fluxdata 
    [ $ROOT_IS_LUKS -eq 1 ] && luks_create_root

    #restore fluxdata
    if [ $FLUXDATA_IS_LUKS -eq 1 ] || [ $ROOT_IS_LUKS -eq 1 ]; then
	luks_restore_fluxdata
    fi

    # create LUKS for others
    # luks_create_others

    # kill rngd daemon
    [ -e ${TMP_DIR}/rngd.pid ] && pkill --signal KILL --pid ${TMP_DIR}/rngd.pid

    mounted_raw_dev=$(mount |grep /dev/mapper | cut -f 1 -d " ")

    #print_verbose "Unmounting all newly created LUKS"
    for rawdev in ${mounted_raw_dev}; do
	umount $rawdev
    done

    return 0

}

_luks_map () {

    # we recognize partition via rawdev
    luks_rawdev=$1

    [ -z "${luks_rawdev}" ] && return 1

    mount |grep "luks_${luks_rawdev##*/}" || luks-setup.sh -N -m -d "${luks_rawdev}" -n "luks_${luks_rawdev##*/}"

    return 0
}


_luks_unmap () {

    # we recognize partition via rawdev
    luks_rawdev=$1

    [ -z "${luks_rawdev}" ] && return 1
    
    luks-setup.sh -N -u -d "${luks_rawdev}" -n "luks_${luks_rawdev##*/}"
    [ $? == 0 ] || {
	print_warning "Unable to unmap luks partition ${luks_rawdev} !"
	return 1
    }

    return 0
}


# mount LABEL=xxxx on specified path
# return code:
# 0: success
# 1: label or mount point is empty
# 2: No partition found with given label
# 3: mount point creation failed
# 4: mount failures, i.e. FS not foramtted
_luks_mount_label () {
    label=$1
    mnt_point=$2

    if [ -z $label ] || [ -z $mnt_point ]; then
	echo "Missing mount LABEL or point"
	return 1
    fi

    #print_verbose "Mounting LABEL=$label on $mnt_point"
    rawdev=$(get_dev_from_label $label)
    
    [ -z ${rawdev} ] && {
	echo "No partition found with LABEL=$label."
	return 2
    }

    # return if alreay mounted
    mount |grep "$rawdev" && return 0

    create_dir $mnt_point || {
	echo "Can't create directory for moint point ${mnt_point}."
	return 3
    }

    mount -o ${MOUNT_FLAG} "LABEL=${label}" ${mnt_point}

    [ $? = 0 ] && return 0 || return 4 
}

luks_map_all () {

    luks_rawdevs="$(blkid -s TYPE | grep crypto_LUKS | awk -F: '{ print $1 }')"

    [ -z "${luks_rawdevs}" ] && return 0

    for luks_rawdev in ${luks_rawdevs}; do
	ls /dev/mapper/* |grep -q /dev/mapper/${LUKS_PREFIX_LABEL}${luks_rawdev##*/} || {
	    _luks_map ${luks_rawdev}
	    [ $? -eq 0 ] || return 1
	}
    done

    # luks_check_restore_root

    return 0
}

_luks_relabel() {
    luks_label=$1

    [ -z "${luks_label}" ] && {
        print_info "No luks label given to relabel(), skipping..."
        return 0
    }

    luks_rawdev_path=`blkid -t LABEL="${luks_label}"  | awk -F: '{ print $1 }'`
    label_name=${luks_label##*"${LUKS_PREFIX_LABEL}"}

    e2label ${luks_rawdev_path} ${label_name}

    return 0
}

# if no tpm module found, label "${LUSK_PREFIX_LABEL}xxx" should be renamed to "xxx"
luks_relabel_all() {

    # get all luks_xxx at this moment
    luks_label_to_be_created="$(blkid -s LABEL | grep LABEL=\"${LUKS_PREFIX_LABEL} | awk -F: '{ print $2 }' | cut -f 2 -d "\"" |xargs)"

    for luks_label in ${luks_label_to_be_created}; do
	_luks_relabel ${luks_label}
    done

    return 0
}

luks_restore_fluxdata() {

    [ -z "${FLUXDATA_LABEL}" ] && return 0
    _luks_mount_label ${ROOT_LABEL} ${TMP_MNT_ROOT} || return 1 

    _luks_mount_label ${FLUXDATA_LABEL} ${TMP_MNT_FLUXDATA} || return 1 

    cp -arf ${TMP_MNT_ROOT}/ostree/deploy/pulsar-linux/deploy/*/var/* ${TMP_MNT_FLUXDATA}/

    sync && umount_dir ${TMP_MNT_ROOT} && umount_dir ${TMP_MNT_FLUXDATA}

    return 0
}

scan_part() {

    ROOT_LABEL=${ROOT_LABEL##*LABEL=}
    [ -z "${ROOT_LABEL}" ] && {
        echo "No root partition specified, aborting..."
	exit 1
    } || {
        TMP_MNT_ROOT="$TMP_MNT/${ROOT_LABEL}"
        #BACKUP_ROOT_LABEL="${ROOT_LABEL}${FACTORY_BACKUP_LABEL}"
        #TMP_MNT_BACKUP_ROOT="$TMP_MNT/${BACKUP_ROOT_LABEL}"
    }

    [ ! -z "$FLUXDATA_LABEL" ] && {
        TMP_MNT_FLUXDATA="$TMP_MNT/${FLUXDATA_LABEL}"
        ROOT_BACKUP_DIR="${TMP_MNT_FLUXDATA}"
    }

    return 0

}


scan_part

detect_tpm_chip

if [ $? -eq 0 ]; then
    luks_detect
    [ -z "${LUKS_LABEL_TO_BE_CREATED}" ] || luks_create

    luks_map_all && {
	umount_dir ${TMP_MNT_ROOT}
	umount_dir ${TMP_MNT_FLUXDATA}
	sync && rm -rf $TMP_MNT
	exit 0
    }
fi

echo "No tpm 2.0 found or not working, restoring partition label..."
umount_dir ${TMP_MNT_ROOT}
umount_dir ${TMP_MNT_FLUXDATA}
rm -rf $TMP_MNT
luks_relabel_all

exit 0
