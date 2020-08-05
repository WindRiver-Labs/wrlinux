# The bootfs.sh in Application SDK

## Summary

The Application SDK provides an initial image deployment tool
called bootfs.sh. You can see the help message by running the
following, assuming you install and enable SDK

$ bootfs.sh -h

usage: bootfs.sh [args]

This command will build a small boot image which can be used for
deployment with OSTree.

Local Install Options:
 -L       Create an image with a copy of the OSTree repository
          from the deploy area, it will be used to for the initial
          device install
 -l <dir> Use a different directory for an install from a local
          repository
 -l 0     Create a local repository with only the deploy branch

Network Install options:
 -b <branch>  branch to use for net install instbr=
 -u <url>     url to use for net install insturl=
 -d <device>  device to use for net install instdev=
 -a <args>    Additional kernel boot argument for the install

Image Creation Options:
 -B         Skip build of the bootfs directory and use what ever is in there
 -e <file>  env file for reference image e.g. core-image-minimal.env
 -n         Turn off the commpression of the image
 -N         Do not modify the boot.scr file on the image
 -s <#>     Size in MB of the boot partition (default 256)
            Setting this to zero will make the partition as small as possible
 -w         Skip wic disk creation

*NOTE* Since bootfs.sh to work out of a build project, option -e <file>
is mandatory

The initial deployment tool will create a ustart image file which can be
copied to boot media or media which will be a permanent part of the
device.  The OSTREE_REMOTE_URL must be defined in the env file in
order to perform a network deployment.  The bootfs.sh tool can
generate an image which contains the ostree_repo which will be
deployed on the first boot, or it can use the network as the point to
retrieve the data in the ostree_repo.

## Use Case
1. Install and enable App SDK
$ ./wrlinux-*-container-base-sdk.sh -y -d <dir>
$ cd <dir>
$ . environment-setup-*-wrs-linux

2. Use appsdk to generate ostree_repo and env file
$ appsdk --log-dir log genimage <Input_Yaml>

Or first run and no Input Yaml file, use default set
$ appsdk --log-dir log genimage

$ls <dir>/deploy/ostree_repo <dir>/deploy/wrlinux-image-small-*.env

3. Construct a bootable image ustart.img.gz
$ bootfs.sh -L -e <dir>/deploy/wrlinux-image-small-*.env

Or

$ bootfs.sh -l <dir>/deploy/ostree_repo -e <dir>/deploy/wrlinux-image-small-*.env

$ ls ustart.*
ustart.env  ustart.img.bmap  ustart.img.gz  ustart.wks

