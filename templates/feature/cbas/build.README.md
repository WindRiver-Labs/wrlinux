# Wind River Linux App SDK for CBAS - How to build
Provide two ways to build
- Way 1 - Step by step for each machine;
- Way 2 - Reuse binary distribution build by a script gen-image

## Supported machine
intel-x86-64
bcm-2xxx-rpi4

## Way 1: Step by step
### Setup project
$ setup.sh --machines=[intel-x86-64|bcm-2xxx-rpi4] --dl-layers \
    --templates feature/ostree feature/cbas --layers wr-ostree

### Source a build
$ . ./oe-init-build-env

### Set local.conf
cat << ENDOF >> conf/local.conf
PACKAGE_FEED_BASE_PATHS = "rpm"
PACKAGE_FEED_URIS = "http://<web-server-url>/cbas"
PACKAGE_FEED_ARCHS_intel-x86-64 = "corei7_64 intel_x86_64 noarch"
PACKAGE_FEED_ARCHS_bcm-2xxx-rpi4 = "cortexa72 bcm_2xxx_rpi4 noarch"
ENDOF

### Build
#### Create rpm repository
$ bitbake world && bitbake package-index

$ ls tmp-glibc/deploy/rpm/*/repodata/repomd.xml -1
tmp-glibc/deploy/rpm/corei7_64/repodata/repomd.xml
tmp-glibc/deploy/rpm/intel_x86_64/repodata/repomd.xml
tmp-glibc/deploy/rpm/noarch/repodata/repomd.xml

Or

$ ls tmp-glibc/deploy/rpm/*/repodata/repomd.xml -1
tmp-glibc/deploy/rpm/cortexa72/repodata/repomd.xml
tmp-glibc/deploy/rpm/bcm_2xxx_rpi4/repodata/repomd.xml
tmp-glibc/deploy/rpm/noarch/repodata/repomd.xml

Above ls only list required repodata

#### Create base reference container
$ bitbake container-base

#### Create container-base appsdk
$ bitbake container-base -cpopulate_sdk

$ ls tmp-glibc/deploy/sdk/wrlinux-graphics-*-container-base-sdk.sh

### Setup rpm repo on http server
Setup a web server (such as httpd, apache2), and create a symlink
to deploy dir

$ ln -snf path-to-build/tmp-glibc/deploy /var/www/html/cbas

Then http://<web-server-url>/cbas is accessible

### Base reference container
wget http://<web-server-url>/cbas/images/intel-x86-64/container-base-intel-x86-64.tar.bz2

Or

wget http://<web-server-url>/cbas/images/bcm-2xxx-rpi4/container-base-bcm-2xxx-rpi4.tar.bz2

### App SDK
wget http://<web-server-url>/cbas/sdk/wrlinux-graphics-10.2X.XX.X-glibc-x86_64-intel_x86_64-container-base-sdk.sh

Or

wget http://<web-server-url>/cbas/sdk/wrlinux-graphics-10.2X.XX.X-glibc-x86_64-bcm_2xxx_rpi4-container-base-sdk.sh

## Way 2: Reuse binary distribution build
### Setup project
$ setup.sh --dl-layers --templates feature/ostree feature/cbas \
    --layers wr-ostree

### Source a build
$ . ./oe-init-build-env

### Set local.conf
cat << ENDOF >> conf/local.conf
PACKAGE_FEED_URIS = "http://<web-server-url>/cbas"
ENDOF

### Build
../layers/wrlinux/scripts/gen-image/gen-image -p lincd -m intel-x86-64 && \
    ../layers/wrlinux/scripts/gen-image/gen-image -p lincd -m bcm-2xxx-rpi4

### Setup rpm repo on http server
Setup a web server (such as httpd, apache2), and create a symlink
to outdir

$ ln -snf path-to-build/outdir /var/www/html/cbas

Then http://<web-server-url>/cbas is accessible

### Base reference container
wget http://<web-server-url>/cbas/WRLinux-CD-Images/intel-x86-64/cbas-intel-x86-64/container-base-intel-x86-64.tar.bz2

And

wget http://<web-server-url>/cbas/WRLinux-CD-Images/bcm-2xxx-rpi4/cbas-bcm-2xxx-rpi4/container-base-bcm-2xxx-rpi4.tar.bz2

### App SDK
wget http://<web-server-url>/cbas/WRLinux-CD-Images/intel-x86-64/cbas-intel-x86-64/wrlinux-graphics-10.2X.XX.X-glibc-x86_64-intel_x86_64-container-base-sdk.sh

And

wget http://<web-server-url>/cbas/WRLinux-CD-Images/bcm-2xxx-rpi4/cbas-bcm-2xxx-rpi4/wrlinux-graphics-10.2X.XX.X-glibc-x86_64-bcm_2xxx_rpi4-container-base-sdk.sh

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
