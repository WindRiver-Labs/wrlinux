#!/bin/bash

# Usage:
#
# Create a project directory with setup.sh:
# $ git clone --branch WRLINUX_10_<version> <url>/wrlinux-x
# $ wrlinux-x/setup.sh --all-layers
#
# Then run:
# $ layers/wrlinux/scripts/gen_common_native_package_list.sh wrlinux-x [ bsp1 bsp2... ]
#
# If bsps have not been specified, the script will query setup.sh for a list.
#
# The script will overwrite the wr-common-native-packages.inc file in
# layers/wr-base under the project directory.

#set -x
wrlinux_dir="$(readlink -f "$1")"

# We assume we are creating the build directory, so we append
# info to local.conf.
#
# runbb <build-dir> <machine> <distro> <image>
#
runbb () {
    (
        if [ -e ./environment-setup-x86_64-wrlinuxsdk-linux ]; then
           . ./environment-setup-x86_64-wrlinuxsdk-linux
        fi
        . ./oe-init-build-env "$1" > /dev/null

        cat >> conf/local.conf << EOF

### ip-generation info ###

MACHINE = "$2"
DISTRO = "$3"

PATCHRESOLVE = "noop"

# Workaround
INSTALLER_TARGET_BUILD = "/dummy"

EOF
        bitbake -g "$4"
    )
}

# Crude parsing of output from setup.sh --list-machines
#
list_machines () {
    "$wrlinux_dir"/setup.sh --list-machines | awk '{if (substr($0, 0, 1) != " ") print $1;}' | while read -r item1 restofline; do
        case $item1 in
            ===*) separator_seen=1
                  continue
                  ;;
            *)  if [ "$separator_seen" = "1" ]; then
                    echo "$item1"
                    :
                fi
                ;;
        esac
    done
}

# Take a list of bsp's, or process all of them.
#
shift
bsps="$*"
[ -z "$bsps" ] && bsps=$(list_machines)

mkdir -p plists

# For each active bsp extract the native packages it requires from the
# package-depends graph file that runbb creates.
# This assumes the glibc-std-sato is a superset of the native packages
# required for each bsp and other rootfs like glibc-std.
#
for bsp in $bsps; do
    echo "Processing $bsp"
    bDir="build-$bsp"
    runbb "$bDir" "$bsp" wrlinux-graphics wrlinux-image-std-sato
    if [ -f "$bDir"/task-depends.dot ]; then
        cut -d">" -f1 "$bDir"/task-depends.dot | grep -v '\[label=' | grep native | grep populate_sysroot | cut -d" " -f1 | uniq | cut -c 2- | sed 's/\(.*\).do_populate_sysroot"/\1/' > "plists/${bsp}-native-packages.txt"
    fi
done

# Make a combined list of all required native packages. Specify
# the sort ordering rather than rely on the default.
#
cat plists/*.txt | env LC_ALL=C sort | uniq > plists/common-native-packages.txt

# Write the include file used in the common native packagegroup.
#
inc_file="layers/wrlinux/recipes-base/wr-common-packages-native/wr-common-packages-native.inc"
warning_text="#This file is autogenerated by scripts/gen_common_native_package_list.sh. DO NOT edit by hand"
{
    echo "$warning_text"
    echo "DEPENDS = \"\\"
    sed 's/\(.*\)/    \1 \\/' plists/common-native-packages.txt
    echo "    \""
    echo "$warning_text"
} > $inc_file

