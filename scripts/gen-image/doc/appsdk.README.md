# Wind River Linux App SDK for CBAS

## Supported host
X86-64

## Installed packages
Check sdk.host.manifest and sdk.target.manifest

## Install the SDK to <dir>
$ ./wrlinux-*-container-base-sdk.sh -y -d <dir>

## Enable SDK
$ cd <workdir>
$ . <dir>/environment-setup-*-wrs-linux

## Application SDK Management Tool for CBAS
$ appsdk -h
usage: appsdk [-h] [-d] [-q] [--log-dir LOGDIR] {gensdk,checksdk,genrpm,publishrpm,genimage,geninitramfs,gencontainer,genyaml,exampleyamls} ...

Application SDK Management Tool for CBAS

positional arguments:
  {gensdk,checksdk,genrpm,publishrpm,genimage,geninitramfs,gencontainer,genyaml,exampleyamls}
                        Subcommands. "appsdk <subcommand> --help" to get more info
    gensdk              Generate a new SDK
    checksdk            Sanity check for SDK
    genrpm              Build RPM package
    publishrpm          Publish RPM package
    genimage            Generate images from package feeds for specified machines
    geninitramfs        Generate Initramfs from package feeds for specified machines
    gencontainer        Generate Container Image from package feeds for specified machines
    genyaml             Generate Yaml file from Input Yamls
    exampleyamls        Deploy Example Yaml files

optional arguments:
  -h, --help            show this help message and exit
  -d, --debug           Enable debug output
  -q, --quiet           Hide all output except error messages
  --log-dir LOGDIR      Specify dir to save debug messages as log.appsdk regardless of the logging level

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

### Publish RPM package
appsdk publishrpm -h
usage: appsdk publishrpm [-h] -r REPO [rpms [rpms ...]]

positional arguments:
  rpms                  RPM package paths

optional arguments:
  -h, --help            show this help message and exit
  -r REPO, --repo REPO  RPM repo path

### Generate example Yamls
$ appsdk exampleyamls -h
usage: appsdk exampleyamls [-h] [-o OUTDIR]

optional arguments:
  -h, --help            show this help message and exit
  -o OUTDIR, --outdir OUTDIR
                        Specify output dir, default is current working directory

$ appsdk exampleyamls
appsdk - INFO: Deploy Directory: path-to-outdir/exampleyamls
+-----------+------------------------------------------+
| Yaml Type |                   Name                   |
+===========+==========================================+
| Image     | container-base-intel-x86-64.yaml         |
|           | core-image-minimal-intel-x86-64.yaml     |
|           | core-image-sato-intel-x86-64.yaml        |
|           | initramfs-ostree-image-intel-x86-64.yaml |
|           | wrlinux-image-small-intel-x86-64.yaml    |
|           |                                          |
+-----------+------------------------------------------+
| Feature   | feature/package_management.yaml          |
|           | feature/vboxguestdrivers.yaml            |
|           | feature/xfce_desktop.yaml                |
|           |                                          |
+-----------+------------------------------------------+
appsdk - INFO: Then, run genimage or genyaml with Yaml Files:
appsdk genimage <Image>.yaml <Feature>.yaml
Or
appsdk genyaml <Image>.yaml <Feature>.yaml

Image Yamls:
- These image Yamls does not list all installed packages, it refers
  PACKAGE_INSTALL from Yocto (bitbake -e <image>)

- For core-image-minimal, core-image-sato, wrlinux-image-small,
  the image type is ostree_repo and ustart, they are used by
  `appsdk genimage' only

- For conainer-base, the image type is container, it is used by
  `appsdk gencontainer' only

- For initramfs-ostree-image, the image type initramfs, it is used by
  `appsdk geninitramfs' only

Feature Yamls:
- Attention: these feature Yamls could not random combination with
  image Yamls, such as vboxguestdrivers.yaml and xfce_desktop.yaml
  does not work on initramfs and container image

- To follow WRLinux CD Release, wrlinux-image-small-intel-x86-64.yaml +
  {package_management.yaml,vboxguestdrivers.yaml,xfce_desktop.yaml}
  is verified

### Generate ostree repo and wic/vmdk/vdi/ustart image from package feed
$ appsdk genimage -h
usage: appsdk genimage [-h] [-o OUTDIR] [-g GPGPATH] [-w WORKDIR] [-t {wic,vmdk,vdi,ostree-repo,ustart,all}] [-n NAME] [-u URL] [-p PKG] [--pkg-external PKG_EXTERNAL]
                       [--rootfs-post-script ROOTFS_POST_SCRIPT] [--rootfs-pre-script ROOTFS_PRE_SCRIPT] [--env ENV] [--no-clean]
                       [input [input ...]]

positional arguments:
  input                 Input yaml files that the tool can be run against a package feed to generate an image

optional arguments:
  -h, --help            show this help message and exit
  -o OUTDIR, --outdir OUTDIR
                        Specify output dir, default is current working directory
  -g GPGPATH, --gpgpath GPGPATH
                        Specify gpg homedir, it overrides 'gpg_path' in Yaml, default is /tmp/.cbas_gnupg
  -w WORKDIR, --workdir WORKDIR
                        Specify work dir, default is current working directory
  -t {wic,vmdk,vdi,ostree-repo,ustart,all}, --type {wic,vmdk,vdi,ostree-repo,ustart,all}
                        Specify image type, it overrides 'image_type' in Yaml
  -n NAME, --name NAME  Specify image name, it overrides 'name' in Yaml
  -u URL, --url URL     Specify extra urls of rpm package feeds
  -p PKG, --pkg PKG     Specify extra package to be installed
  --pkg-external PKG_EXTERNAL
                        Specify extra external package to be installed
  --rootfs-post-script ROOTFS_POST_SCRIPT
                        Specify extra script to run after do_rootfs
  --rootfs-pre-script ROOTFS_PRE_SCRIPT
                        Specify extra script to run before do_rootfs
  --env ENV             Specify extra environment to export before do_rootfs: --env NAME=VALUE
  --no-clean            Do not cleanup generated rootfs in workdir

$ appsdk genimage input.yaml --type all
appsdk - INFO: Deploy Directory: path-to-outdir/deploy
+------------------+-----------------------------------------------------------+
|       Type       |                           Name                            |
+==================+===========================================================+
| Image Yaml File  | wrlinux-image-small-intel-x86-64.yaml                     |
+------------------+-----------------------------------------------------------+
| Ostree Repo      | ostree_repo                                               |
+------------------+-----------------------------------------------------------+
| WIC Image        | wrlinux-image-small-intel-x86-64.wic -> wrlinux-image-    |
|                  | small-intel-x86-64-20200908060827.rootfs.wic              |
+------------------+-----------------------------------------------------------+
| WIC Image Doc    | wrlinux-image-small-intel-x86-64.wic.README.md            |
+------------------+-----------------------------------------------------------+
| WIC Image        | wrlinux-image-small-intel-x86-64.qemuboot.conf ->         |
| Qemu Conf        | wrlinux-image-small-                                      |
|                  | intel-x86-64-20200908060827.qemuboot.conf                 |
+------------------+-----------------------------------------------------------+
| VDI Image        | wrlinux-image-small-intel-x86-64.wic.vdi -> wrlinux-      |
|                  | image-small-intel-x86-64-20200908060827.rootfs.wic.vdi    |
+------------------+-----------------------------------------------------------+
| VMDK Image       | wrlinux-image-small-intel-x86-64.wic.vmdk -> wrlinux-     |
|                  | image-small-intel-x86-64-20200908060827.rootfs.wic.vmdk   |
+------------------+-----------------------------------------------------------+
| Ustart Image     | wrlinux-image-small-intel-x86-64.ustart.img.gz ->         |
|                  | wrlinux-image-small-                                      |
|                  | intel-x86-64-20200908060827.ustart.img.gz                 |
+------------------+-----------------------------------------------------------+
| Ustart Image Doc | wrlinux-image-small-intel-x86-64.ustart.img.gz.README.md  |
+------------------+-----------------------------------------------------------+

If no option --type, it generates ostree repo and ustart image by default

### Generate initramfs image from package feed
$ appsdk geninitramfs -h
It is similar with `appsdk genimage -h', the differ is `--type initramfs'
If image name is `initramfs-ostree-image' (by default), it will replace existed
initrd used by the generation of wic/ustart image (appsdk genimage)

$ appsdk geninitramfs
appsdk - INFO: Deploy Directory: path-to-outdir/deploy
+-------+----------------------------------------------------------------------+
| Image | initramfs-ostree-image-intel-x86-64.cpio.gz -> initramfs-ostree-     |
|       | image-intel-x86-64-20200908062501.rootfs.cpio.gz                     |
+-------+----------------------------------------------------------------------+

### Generate container image from package feed
$ appsdk gencontainer -h
It is similar with `appsdk genimage -h', the differ is `--type container'

$ appsdk gencontainer
appsdk - INFO: Deploy Directory: path-to-outdir/deploy
+---------------------+--------------------------------------------------------+
| Container Image     | container-base-intel-x86-64.container.tar.bz2 ->       |
|                     | container-base-                                        |
|                     | intel-x86-64-20200908062849.container.rootfs.tar.bz2   |
+---------------------+--------------------------------------------------------+
| Container Image Doc | container-base-                                        |
|                     | intel-x86-64.container.tar.bz2.README.md               |
+---------------------+--------------------------------------------------------+

### Generate/Customize Yaml file
$ appsdk genyaml -h
It is similar with `appsdk genimage -h', the differ is `--type {wic,vmdk,vdi,
ostree-repo,container,initramfs,ustart,all}'

$ appsdk genyaml exampleyamls/wrlinux-image-small-intel-x86-64.yaml exampleyamls/feature/xfce_desktop.yaml
appsdk - INFO: Input YAML File: exampleyamls/wrlinux-image-small-intel-x86-64.yaml
appsdk - INFO: Input YAML File: exampleyamls/feature/xfce_desktop.yaml
appsdk - INFO: Save Yaml FIle to : path-to-outdir/wrlinux-image-small-intel-x86-64.yaml

Customize order: Default setting < Section in Yaml < Command option

- Section in Yaml overrides default setting
  If the section in Yaml is missing, use default setting to replace

- Install default packages or not
  Use include-default-packages section in Yaml, if set 1, install default
  packages to image; if set 0, the packages section in Yaml overrides default
  packages. The default include-default-packages is 1.

- Command option overrides section in Yaml
  The options --gpgpath, --type, --name, override the sections in input.yaml

- Command option append section in Yaml
  The options --url, --pkg, --pkg-external, --rootfs-post-script,
  --rootfs-pre-script, --env, append value to the sections in input.yaml.
  If values are duplicated, only one copy is used.

- Set environment variable for rootfs generation
  For option --env and section `environments', if the same environment variable
  is set multiple times (such as NAME=VALUE1, NAME=VALUE2), only the last set
  (NAME=VALUE2) works

- Customize rootfs by script
  For option --rootfs-pre-script/--rootfs-post-script and section
  rootfs-pre-scripts/rootfs-post-scripts which allows you to run a script
  using the pseudo context to customize rootfs. The `pre' means run script
  before rootfs generation, the `post' means run script after rootfs
  generation. Define an environment variable IMAGE_ROOTFS for the location
  of the rootfs install directory


- Collect the following sections from multiple Yamls, the duplication
  is allowed:

  - packages
  - external-packages
  - environments
  - rootfs-pre-scripts
  - rootfs-post-scripts

  But duplication is not allowed for other sections such as section name,
  machine and so on.

Input yaml format:
[exampleyamls/wrlinux-image-small-intel-x86-64.yaml begin]
name: wrlinux-image-small
machine: intel-x86-64
image_type:
- ostree-repo
- ustart
- vdi
- vmdk
- wic
package_feeds:
- http://XXXX/cbas/WRLinux-CD-Images/intel-x86-64/repos/rpm/corei7_64
- http://XXXX/cbas/WRLinux-CD-Images/intel-x86-64/repos/rpm/intel_x86_64
- http://XXXX/cbas/WRLinux-CD-Images/intel-x86-64/repos/rpm/noarch
ostree:
  OSTREE_CONSOLE: console=ttyS0,115200 console=tty1
  OSTREE_FDISK_BLM: '2506'
  OSTREE_FDISK_BSZ: '200'
  OSTREE_FDISK_FSZ: '32'
  OSTREE_FDISK_RSZ: '4096'
  OSTREE_FDISK_VSZ: '0'
  OSTREE_GRUB_PW_FILE: $OECORE_NATIVE_SYSROOT/usr/share/bootfs/boot_keys/ostree_grub_pw
  OSTREE_GRUB_USER: root
  ostree_osname: wrlinux
  ostree_remote_url: ''
  ostree_skip_boot_diff: '2'
  ostree_use_ab: '0'
wic:
  OSTREE_FLUX_PART: fluxdata
  OSTREE_WKS_BOOT_SIZE: ''
  OSTREE_WKS_EFI_SIZE: --size=32M
  OSTREE_WKS_FLUX_SIZE: ''
  OSTREE_WKS_ROOT_SIZE: ''
remote_pkgdatadir: http://XXXX/cbas/WRLinux-CD-Images/intel-x86-64/repos/rpm
features:
  image_linguas: 'en-us'       # Specifies the list of locales to
                               # install into the image during the
                               # root filesystem construction process.
  pkg_globs: '*-src, *-dev, *-dbg' # Install complementary packages
                                   # based upon the list of currently
                                   # installed packages
                                   # e.g. *-src, *-dev, *-dbg
gpg:
  gpg_path: /tmp/.cbas_gnupg   # Specify gpg homedir, dir length is no
                               # more than 80 chars, make sure the
                               # permission on dir
  grub:
    BOOT_GPG_NAME: SecureBootCore
    BOOT_GPG_PASSPHRASE: SecureCore
    BOOT_KEYS_DIR: $OECORE_NATIVE_SYSROOT/usr/share/bootfs/boot_keys
  ostree:
    gpg_password: windriver
    gpgid: Wind-River-Linux-Sample
    gpgkey: $OECORE_NATIVE_SYSROOT/usr/share/genimage/rpm_keys/RPM-GPG-PRIVKEY-Wind-River-Linux-Sample
packages:
- ca-certificates
- glib-networking
- grub-efi
- i2c-tools
- intel-microcode
- iucode-tool
- kernel-modules
- lmsensors
- os-release
- ostree
- ostree-upgrade-mgr
- packagegroup-busybox-replacement
- packagegroup-core-boot
- rtl8723bs-bt
- run-postinsts
- systemd
external-packages: []
include-default-packages: '0'
rootfs-pre-scripts:
- echo "run script before do_rootfs in $IMAGE_ROOTFS"
rootfs-post-scripts:
- echo "run script after do_rootfs in $IMAGE_ROOTFS"
environments:
- KERNEL_PARAMS="key=value"
- NO_RECOMMENDATIONS="0"
[exampleyamls/wrlinux-image-small-intel-x86-64.yaml end]

## Use case by simple hello-world example

Here's a simple example of how to use appsdk.

1. Download source and build.

   e.g.
   wget http://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz
   tar xzvf hello-2.10.tar.gz
   cd hello-2.10
   ./configure $CONFIGURE_FLAGS
   make
   make DESTDIR=/path/to/install-hello install

2. Generate RPM package

   2a) Create yaml file for hello as below.
   name: hello
   version: '2.10'
   release: r0
   summary: Hello World Program From Gnu
   license: GPLv3

   description: |
     A simple hello world program that only does one thing.
     It's from GNU.

   post_install: |
     #!/bin/sh
     echo "This is the post install script of hello program"
     echo "It only prints some message."

   2b) appsdk genrpm -f hello.yaml -i /path/to/install-hello

3. Publish the RPM package

   3a) Publish the RPM to repo
       mkdir -p /path/to/http_service_data/third_party_repo
       appsdk publishrpm -r /path/to/http_service_data/third_party_repo  deploy/rpms/corei7_64/hello-2.10-r0.corei7_64.rpm

   3b) [OPTIONAL] Setup http service

       python3 -m http.server 8888 --directory /path/to/http_service_data

       Use browser to access http://HOST_IP:8888/third_party_repo/

4. Use the RPM package on target

   4a) Setup RPM repo
       echo > /etc/yum.repos.d/test.repo <<EOF
       [appsdk-test-repo]
       name=appsdk test repo
       baseurl=http://HOST_IP:8888/third_party_repo/
       gpgcheck=0
       EOF

   4b) Install hello package

       dnf install hello

   4c) Run hello program

       e.g.
       root@intel-x86-64:~# hello
       Hello, world!

5. Use the RPM package as input as `appsdk genimage` and `appsdk gensdk`

   5a) Modify yaml file

       Add 'http://HOST_IP:8888/third_party_repo/' to package_feeds section.
       Add 'hello' to external-packages section.

       e.g.
       machine: intel-x86-64
       name: custom-image
       image_type:
       - ostree-repo
       - wic
       - container
       - ustart
       package_feeds:
       - http://<web-server-url>/cbas/WRLinux-CD-Images/intel-x86-64/repos/rpm/noarch/
       - http://<web-server-url>/cbas/WRLinux-CD-Images/intel-x86-64/repos/rpm/corei7_64/
       - http://<web-server-url>/cbas/WRLinux-CD-Images/intel-x86-64/repos/rpm/intel_x86_64/
       - http://HOST_IP:8888/third_party_repo
       packages:
       - base-files
       - base-passwd
       - bash
       - systemd
       external-packages:
       - hello

    5b) appsdk genimage image-with-hello.yaml
        appsdk gensdk -f image-with-hello.yaml


Check environment-setup-*-wrs-linux for the exported variables.

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
