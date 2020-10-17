# Wind River Linux App SDK for CBAS - Run appsdk in build
Compare with appsdk in SDK:

- The appsdk in the build uses local package feed of the same build.

- If set PACKAGE_FEED_URIS and PACKAGE_FEED_URIS, the remote package
feed will be saved as target yum repo. It will not be used by appsdk
to generate image, but be used by dnf at target run time. Please make
sure the remote package feed is available on web server

- The appsdk in the build does not provide subcommand gensdk and
checksdk

## Supported machine
intel-x86-64
bcm-2xxx-rpi4

## Build steps
### Setup project
$ setup.sh --machines=[intel-x86-64|bcm-2xxx-rpi4] --dl-layers \
    --distro=wrlinux-graphics \
    --templates feature/ostree feature/cbas feature/docker --layers wr-ostree

### Source a build
$ . ./oe-init-build-env

### Build
#### Build with minimal rpms
$ bitbake appsdk-native && bitbake package-index build-sysroots

#### Build with full rpms
$ bitbake world appsdk-native && bitbake package-index build-sysroots

## Run appsdk
$ tmp-glibc/sysroots/x86_64/usr/bin/appsdk -h

## Enable bash completion of appsdk (optional, host bash >= 4.2)
The bash completion of appsdk requires host bash support for
complete -D, which was introduced in bash 4.2

$ bash --rcfile tmp-glibc/sysroots/x86_64/environment-appsdk-native
$ appsdk <TAB>
-d            exampleyamls  genimage      genrpm        -h            --log-dir     -q
--debug       gencontainer  geninitramfs  genyaml       --help        publishrpm    --quiet

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
