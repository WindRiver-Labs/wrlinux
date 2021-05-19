# Wind River Linux images SDK

The SDK is used for the following 4 images
container/wrlinux-image-minimal
container/wrlinux-image-full
target/wrlinux-image-minimal
target/wrlinux-image-full

## Supported host
X86-64

## Installed packages
Check sdk.host.manifest and sdk.target.manifest

## Install the SDK
$ ./wrlinux-*-wrlinux-image-full-sdk.sh

## Enable SDK
$ . environment-setup-*-wrs-linux

Check environment-setup-*-wrs-linux for the exported variables.

## Use SDK's compiler
$ $CC <src>.c

Use $CONFIGURE_FLAGS if you need run configure:
$ ./configure $CONFIGURE_FLAGS

## Sources
Source code required to build the sdk is provided here:
https://distro.windriver.com/wrlinux/lts-21/dist/sources

## License
The sdk is provided under the GPL-2.0 license.

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

The sdk includes third party software which might be available under
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
