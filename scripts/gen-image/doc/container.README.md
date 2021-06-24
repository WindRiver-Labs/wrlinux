# Wind River Linux container images

The images are built from Wind River Linux CD release, which support docker, kubernetes, xfce and other features in the packages feeds. The images can be highly customized, which can be customized by package manager dnf, or use the script gen-image to rebuild them from source.

## Supported BSPs
### x86-64
    intel-x86-64
    qemux86-64

### rpi4
    bcm-2xxx-rpi4
    qemuarm64

## Features
### x86-64
    Arch: x86_64 (corei7_64)
    Package Manager: dnf
    glibc: 2.31
    Features: docker kubernetes xfce

### rpi4
    Arch: aarch64 (cortexa72)
    Package Manager: dnf
    glibc: 2.31
    Features: docker kubernetes xfce

## Image types
### wrlinux-image-minimal
A busybox based minimal image that boots to a console, can be expanded to a
large image via package manager dnf.

### wrlinux-image-full
A full functional image that boots to a console, no busybox installed but other
common tools such as coreutils, and is installed by default.

## Install a package
    $ dnf install <package>

## Remove a package
    $ dnf remove <package>

## Dockerfile
### wrlinux-image-minimal
    FROM scratch
    ADD wrlinux-image-minimal-<machine>.tar.bz2 /
    CMD ["/bin/sh"]

### wrlinux-image-full
    FROM scratch
    ADD wrlinux-image-full-<machine>.tar.bz2 /
    CMD ["/bin/sh"]

The machine is  intel-x86-64 or bcm-2xxx-rpi4 according to the archs.

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

## Sources
Source code required to build the image is provided here:
https://distro.windriver.com/dist/wrlinux/lts-21/sources

## License
The images are provided under the GPL-2.0 license.

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
