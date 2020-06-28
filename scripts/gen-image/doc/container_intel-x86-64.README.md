# Wind River Linux container images

The images are built from Wind River Linux CD release, which support docker, kubernetes, xfce and other features in the packages feeds. The images can be highly customized, they can be customized by package manager dnf, or use the script gen-image to rebuild them from source.

## Features
Arch: x86_64 (corei7_64)
Package Manager: dnf
glibc: 2.31
Features: docker kubernetes openvino xfce

## Supported BSPs
- intel-x86-64
- qemux86-64

## Image types
### wrlinux-image-minimal
A busybox based minimal image that boots to a console, can be expanded to a
large image via package manager dnf.

### wrlinux-image-full
A full functional image that boots to a console, no busybox installed but other
common tools such as coreutils, and openvino is installed by default.

## Install a package
$ dnf install <package>

## Remove a package
$ dnf remove <package>

## Dockerfile
### wrlinux-image-minimal
 FROM scratch
 ADD wrlinux-image-glibc-minimal-qemux86-64.tar.bz2 /
 CMD ["/bin/sh"]

### wrlinux-image-full
 FROM scratch
 ADD wrlinux-image-glibc-full-qemux86-64.tar.bz2 /
 CMD ["/bin/sh"]

## Known issues
- ecryptfs-utils
ecryptfs-utils includes a systemd service ecryptfs.service and a kernel module
ecryptfs.ko. To make ecryptfs.service in container start successfully,
ecryptfs.ko must be inserted in the host system first either by ecryptfs.service
or manually. And then ecryptfs.service in the host system must be stopped,
otherwise it would hold /dev/ecryptfs and prevents ecryptfs.service in container
from accessing /dev/ecryptfs.

In general, a container may depend on some features or devices in the host
system. How to formally handle such dependencies is to be discussed.

## Build the images from sources
$ mkdir wrlinux-cd
$ cd wrlinux-cd
$ git clone https://distro.windriver.com/sources/wrlinux/linux-cd/base/WRLinux-CD-Core/wrlinux-x/
$ cd wrlinux-x
$ git checkout <tag>

The initial tag is vWRLINUX_CI_10.20.27.0

$ cd ../
$ ./wrlinux-x/setup.sh --all-layers --dl-layers
$ . environment-setup-x86_64-wrlinuxsdk-linux
$ . oe-init-build-env
$ ../layers/wrlinux/scripts/gen-image/gen-image -m intel-x86-64
The images are in outdir/WRLinux-CD-Images/intel-x86-64

## Sources
Source code required to build the image is provided here:
https://distro.windriver.com/sources/wrlinux/linux-cd/base/WRLinux-CD-Core/

To get a package's source:
$ . environment-setup-x86_64-wrlinuxsdk-linux
$ . oe-init-build-env
$ bitbake <package> -cfetch

To get all sources of the image:
$ bitbake <image> --runall=fetch

The sources will be in DL_DIR, and way to get DL_DIR:
$ bitbake -e | grep '^DL_DIR'

## License
The image is provided under the GPL-2.0 license.

Copyright (c) 2020 Wind River Systems Inc.

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License version 2 as published by the Free
Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 59 Temple
Place, Suite 330, Boston, MA 02111-1307 USA

The images include third party software which might be available under
additional open source licenses, including the base Wind River Linux CD
distribution along with third party dependencies.

## Legal Notices
All product names, logos, and brands are property of their respective owners.
All company, product and service names used in this software are for
identification purposes only. Wind River is a registered trademark of Wind River
Systems, Inc. Linux is a registered trademark owned by Linus Torvalds.

Disclaimer of Warranty / No Support: Wind River does not provide support and
maintenance services for this software, under Wind River’s standard Software
Support and Maintenance Agreement or otherwise. Unless required by applicable
law, Wind River provides the software (and each contributor provides its
contribution) on an “AS IS” BASIS, WITHOUT WARRANTIES OF ANY KIND, either
express or implied, including, without limitation, any warranties of TITLE,
NONINFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are
solely responsible for determining the appropriateness of using or
redistributing the software and assume any risks associated with your exercise
of permissions under the license.
