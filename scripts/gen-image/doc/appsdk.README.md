# Wind River Linux App SDK for CBAS

## Supported host
X86-64

## Installed packages
Check sdk.host.manifest and sdk.target.manifest

## Install the SDK
$ ./wrlinux-*-container-base-sdk.sh

## Enable SDK
$ . environment-setup-*-wrs-linux

Check environment-setup-*-wrs-linux for the exported variables.

## Application SDK Management Tool for CBAS
$ appsdk -h
usage: appsdk [-h] [-d] [-q] {gensdk,checksdk,genrpm,genimage} ...

Application SDK Management Tool for CBAS

positional arguments:
  {gensdk,checksdk,genrpm,genimage}
                        Subcommands. "appsdk <subcommand> --help" to get more info
    gensdk              Generate a new SDK
    checksdk            Sanity check for SDK
    genrpm              Build RPM package
    genimage            Generate images from package feeds for specified machines

optional arguments:
  -h, --help            show this help message and exit
  -d, --debug           Enable debug output
  -q, --quiet           Hide all output except error messages

Use appsdk <subcommand> --help to get help

### Generate a new SDK
$ appsdk gensdk -h
usage: appsdk gensdk [-h] [-f FILE] [-o OUTPUT]

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  An input yaml file specifying image information. Default to image.yaml in current directory
  -o OUTPUT, --output OUTPUT
                        The path of the generated SDK. Default to deploy/AppSDK.sh in current directory

$ appsdk gensdk -f input.yaml

Input yaml format:
[input yaml sample]
packages: # A list of packages to be installed on target sysroot
- pkg1
- pkg2
[input yaml sample]


### Sanity check for SDK
$ appsdk checksdk


### Build RPM package
appsdk genrpm -h
usage: appsdk genrpm [-h] -f FILE -i INSTALLDIR [-o OUTPUTDIR] [--pkgarch PKGARCH]

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  A yaml or spec file specifying package information
  -i INSTALLDIR, --installdir INSTALLDIR
                        An installdir serving as input to generate RPM package
  -o OUTPUTDIR, --outputdir OUTPUTDIR
                        Output directory to hold the generated RPM package
  --pkgarch PKGARCH     package arch about the generated RPM package


### Generate a image from package feed
$ appsdk genimage -h
usage: appsdk genimage [-h] [-m {intel-x86-64}] [-o OUTDIR] [-w WORKDIR] [-t {wic,ostree-repo,container,all}] [-n NAME] [-u URL]
                       [-p PKG] [--no-clean]
                       [input]

positional arguments:
  input                 An input yaml file that the tool can be run against a package feed to generate an image

optional arguments:
  -h, --help            show this help message and exit
  -m {intel-x86-64}, --machine {intel-x86-64}
                        Specify machine
  -o OUTDIR, --outdir OUTDIR
                        Specify output dir, default is current working directory
  -w WORKDIR, --workdir WORKDIR
                        Specify work dir, default is current working directory
  -t {wic,ostree-repo,container,all}, --type {wic,ostree-repo,container,all}
                        Specify image type, default is all
  -n NAME, --name NAME  Specify image name
  -u URL, --url URL     Specify extra urls of rpm package feeds
  -p PKG, --pkg PKG     Specify extra package to be installed
  --no-clean            Do not cleanup generated rootfs in workdir

$ appsdk genimage input.yaml

Input yaml format:
[input yaml sample]
features:
  pkg_globs: '*-src, *-dev, *-dbg' # Install complementary packages based upon the list of currently installed
                                   # packages e.g. *-src, *-dev, *-dbg
gpg:
  gpg_path: /tmp/.cbas_gnupg
  ostree:
    gpg_password: windriver
    gpgid: Wind-River-Linux-Sample
    gpgkey: $OECORE_NATIVE_SYSROOT/usr/share/create_full_image/rpm_keys/RPM-GPG-PRIVKEY-Wind-River-Linux-Sample
machine: intel-x86-64
name: wrlinux-image-small  # Image name
ostree:
  ostree_osname: wrlinux
  ostree_remote_url: http://XXXX/WRLinux-CD-Images/intel-x86-64/repos/ostree_repo
  ostree_skip_boot_diff: '2'
  ostree_use_ab: '1'
package_feeds:
- http://XXXX/WRLinux-CD-Images/intel-x86-64/repos/rpm/corei7_64
- http://XXXX/WRLinux-CD-Images/intel-x86-64/repos/rpm/intel_x86_64
packages: # A list of packages to be installed on target image
- pkg1
- pkg2
wic: # Set partition size of wic image
  OSTREE_FLUX_PART: fluxdata
  OSTREE_WKS_BOOT_SIZE: '--size=256M' # Allocate 256MB to /boot
  OSTREE_WKS_EFI_SIZE: --size=32M # Allocate 32MB to /boot/efi, only works on intel-x86-64
  OSTREE_WKS_FLUX_SIZE: '' # Allocate size to /var
  OSTREE_WKS_ROOT_SIZE: '' # Allocate size to rootfs
[input yaml sample]

###


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
