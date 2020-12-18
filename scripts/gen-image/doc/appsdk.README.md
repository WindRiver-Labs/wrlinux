# Wind River Linux Assembly Tool appsdk information

## Supported host
X86-64

## Installed packages
Check sdk.host.manifest and sdk.target.manifest

## Install the SDK to <dir>
```
$ ./wrlinux-*-container-base-sdk.sh -y -d <dir>
```

## Enable SDK
```
$ cd <workdir>
$ . <dir>/environment-setup-*-wrs-linux
```

## Wind River Linux Assembly Tool appsdk usage
```
$ appsdk -h
usage: appsdk [-h] [-d] [-q] [--log-dir LOGDIR] {gensdk,checksdk,genrpm,publishrpm,genimage,geninitramfs,gencontainer,genyaml,exampleyamls} ...

Wind River Linux Assembly Tool

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
```

### Generate a new SDK
```
$ appsdk gensdk -h
usage: appsdk gensdk [-h] [-f FILE] [-o OUTPUT]

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  An input yaml file specifying image information. Default to image.yaml in current directory
  -o OUTPUT, --output OUTPUT
                        The path of the generated SDK. Default to deploy/AppSDK.sh in current directory

$ appsdk gensdk -f input.yaml
```

### Sanity check for SDK
```
$ appsdk checksdk
```

### Build RPM package
```
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
```

### Publish RPM package
```
appsdk publishrpm -h
usage: appsdk publishrpm [-h] -r REPO [rpms [rpms ...]]

positional arguments:
  rpms                  RPM package paths

optional arguments:
  -h, --help            show this help message and exit
  -r REPO, --repo REPO  RPM repo path
```

### Generate example Yamls
```
$ appsdk exampleyamls -h
usage: appsdk exampleyamls [-h] [-o OUTDIR]

optional arguments:
  -h, --help            show this help message and exit
  -o OUTDIR, --outdir OUTDIR
                        Specify output dir, default is current working directory

$ appsdk exampleyamls
appsdk - INFO: Deploy Directory: path-to-outdir/exampleyamls
+-------------------+------------------------------------------+
|     Yaml Type     |                   Name                   |
+===================+==========================================+
| Image             | container-base-intel-x86-64.yaml         |
|                   | core-image-minimal-intel-x86-64.yaml     |
|                   | core-image-sato-intel-x86-64.yaml        |
|                   | initramfs-ostree-image-intel-x86-64.yaml |
|                   | wrlinux-image-small-intel-x86-64.yaml    |
|                   |                                          |
+-------------------+------------------------------------------+
| Feature           | feature/debug-tweaks.yaml                |
|                   | feature/package_management.yaml          |
|                   | feature/set_root_password.yaml           |
|                   | feature/startup-container.yaml           |
|                   | feature/vboxguestdrivers.yaml            |
|                   | feature/xfce_desktop.yaml                |
|                   |                                          |
+-------------------+------------------------------------------+
| System Definition | sysdef/add-system-user.yaml              |
|  Yamls            | sysdef/add-user-home.yaml                |
|                   | sysdef/contains-container-base.yaml      |
|                   | sysdef/set-dns.yaml                      |
|                   | sysdef/set-hostname.yaml                 |
|                   | sysdef/set-ntp.yaml                      |
|                   | sysdef/update-containers.yaml            |
|                   |                                          |
+-------------------+------------------------------------------+
appsdk - INFO: Then, run genimage or genyaml with Yaml Files:
appsdk genimage <Image>.yaml <Feature>.yaml
Or
appsdk genyaml <Image>.yaml <Feature>.yaml
```

Image Yamls:

- These image Yamls does not list all installed packages, it refers
  PACKAGE_INSTALL from Yocto (bitbake -e <image>)

- For core-image-minimal, core-image-sato, wrlinux-image-small,
  the image type is ostree_repo and ustart, they are used by
  'appsdk genimage' only

- For conainer-base, the image type is container, it is used by
  'appsdk gencontainer' only

- For initramfs-ostree-image, the image type initramfs, it is used by
  'appsdk geninitramfs' only

Feature Yamls:

- Attention: these feature Yamls could not random combination with
  image Yamls, such as vboxguestdrivers.yaml and xfce_desktop.yaml
  does not work on initramfs and container image

- To follow WRLinux CD Release, wrlinux-image-small-intel-x86-64.yaml +
  {package_management.yaml,vboxguestdrivers.yaml,xfce_desktop.yaml}
  is verified


### Generate ostree repo and wic/vmdk/vdi/ustart image from package feed
```
$ appsdk genimage -h
usage: appsdk genimage [-h] [-t {wic,vmdk,vdi,ostree-repo,ustart,all}] [-o OUTDIR] [-w WORKDIR] [-n NAME] [-u URL] [-p PKG] [--pkg-external PKG_EXTERNAL]
                       [--rootfs-post-script ROOTFS_POST_SCRIPT] [--rootfs-pre-script ROOTFS_PRE_SCRIPT] [--env ENV] [--no-clean] [--no-validate] [-g GPGPATH]
                       [input [input ...]]

positional arguments:
  input                 Input yaml files that the tool can be run against a package feed to generate an image

optional arguments:
  -h, --help            show this help message and exit
  -t {wic,vmdk,vdi,ostree-repo,ustart,all}, --type {wic,vmdk,vdi,ostree-repo,ustart,all}
                        Specify image type, it overrides 'image_type' in Yaml
  -o OUTDIR, --outdir OUTDIR
                        Specify output dir, default is current working directory
  -w WORKDIR, --workdir WORKDIR
                        Specify work dir, default is current working directory
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
  --no-validate         Do not validate parameters in Input yaml files
  -g GPGPATH, --gpgpath GPGPATH
                        Specify gpg homedir, it overrides 'gpg_path' in Yaml, default is /tmp/.lat_gnupg
  --ostree-remote-url OSTREE_REMOTE_URL
                        Specify ostree remote url, it overrides 'ostree_remote_url' in Yaml, default is None
```
```
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
```
If no option --type, it generates ostree repo and ustart image by default

### Generate initramfs image from package feed
```
$ appsdk geninitramfs -h
It is similar with 'appsdk genimage -h', the differ is no -t/--type option
If image name is 'initramfs-ostree-image' (by default), it will replace existed
initrd used by the generation of wic/ustart image (appsdk genimage)

$ appsdk geninitramfs
appsdk - INFO: Deploy Directory: path-to-outdir/deploy
+-------+----------------------------------------------------------------------+
| Image | initramfs-ostree-image-intel-x86-64.cpio.gz -> initramfs-ostree-     |
|       | image-intel-x86-64-20200908062501.rootfs.cpio.gz                     |
+-------+----------------------------------------------------------------------+
```

### Generate container image from package feed
```
$ appsdk gencontainer -h
It is similar with 'appsdk genimage -h', the differ is no -t/--type and
-g/--gpg-path options

$ appsdk gencontainer
appsdk - INFO: Deploy Directory: path-to-outdir/deploy
+------------------------+-----------------------------------------------------+
| Docker Image           | container-base-intel-x86-64.docker-image.tar.bz2 -> |
|                        | container-base-intel-x86-64-20201012135125.docker-  |
|                        | image.tar.bz2                                       |
+------------------------+-----------------------------------------------------+
| OCI Image Rootfs       | container-base-intel-x86-64.rootfs-oci              |
+------------------------+-----------------------------------------------------+
| Container Image Doc    | container-base-intel-x86-64.container.README.md     |
+------------------------+-----------------------------------------------------+
| Yaml file for genimage | container-base-intel-x86-64.startup-container.yaml  |
| to load and run        |                                                     |
+------------------------+-----------------------------------------------------+
```

### Generate/Customize Yaml file
```
$ appsdk genyaml -h
```
It is similar with 'appsdk genimage -h', the differ is '--type {wic,vmdk,vdi, ostree-repo,container,initramfs,ustart,all}'
```
$ appsdk genyaml exampleyamls/wrlinux-image-small-intel-x86-64.yaml exampleyamls/feature/xfce_desktop.yaml
appsdk - INFO: Input YAML File: exampleyamls/wrlinux-image-small-intel-x86-64.yaml
appsdk - INFO: Input YAML File: exampleyamls/feature/xfce_desktop.yaml
appsdk - INFO: Save Yaml FIle to : path-to-outdir/wrlinux-image-small-intel-x86-64.yaml
```

Customize order: Default setting < Section in Yaml < Command option

- Section in Yaml overrides default setting
  If the section in Yaml is missing, use default setting to replace

- Install default packages or not
  Use include-default-packages section in Yaml, if set 1, install default
  packages to image; if set 0, the packages section in Yaml overrides default
  packages. The default include-default-packages is 1.

- Command option overrides section in Yaml
  The options --gpgpath, --type, --name, --ostree-remote-url, override the
  sections in input.yaml

- Command option append section in Yaml
  The options --url, --pkg, --pkg-external, --rootfs-post-script,
  --rootfs-pre-script, --env, append value to the sections in input.yaml.
  If values are duplicated, only one copy is used.

- Set environment variable for rootfs generation
  For option --env and section 'environments', if the same environment variable
  is set multiple times (such as NAME=VALUE1, NAME=VALUE2), only the last set
  (NAME=VALUE2) works

- Customize rootfs by script
  For option --rootfs-pre-script/--rootfs-post-script and section
  rootfs-pre-scripts/rootfs-post-scripts which allows you to run a script
  using the pseudo context to customize rootfs. The 'pre' means run script
  before rootfs generation, the 'post' means run script after rootfs
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
```
name: wrlinux-image-small
machine: intel-x86-64
image_type:
- ostree-repo
- ustart
- vdi
- vmdk
- wic
package_feeds:
- http://XXXX/lat/WRLinux-CD-Images/intel-x86-64/repos/rpm/corei7_64
- http://XXXX/lat/WRLinux-CD-Images/intel-x86-64/repos/rpm/intel_x86_64
- http://XXXX/lat/WRLinux-CD-Images/intel-x86-64/repos/rpm/noarch
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
remote_pkgdatadir: http://XXXX/lat/WRLinux-CD-Images/intel-x86-64/repos/rpm
features:
  image_linguas: 'en-us'       # Specifies the list of locales to
                               # install into the image during the
                               # root filesystem construction process.
  pkg_globs: '*-src, *-dev, *-dbg' # Install complementary packages
                                   # based upon the list of currently
                                   # installed packages
                                   # e.g. *-src, *-dev, *-dbg
gpg:
  gpg_path: /tmp/.lat_gnupg   # Specify gpg homedir, dir length is no
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
- packagegroup-core-base-utils 
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
```

## Use case by simple hello-world example

Here's a simple example of how to use appsdk.
```
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
   """
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
   """

   Note that user could also specify directories and files like below.
   e.g.
   """
   dirs:
   - /usr (0755, root, root)
   - /usr/local (0755, root, root)
   - /usr/local/bin (0755, root, root)

   files:
   - /usr/local/bin/hello (0755, root, root)
   """
   The path is a must, the permission and owner part is optional.
   For example, we could just use '- /usr' instead of the full
   '- /usr (0755, root, root)'.

   By default, genrpm packages all files, but user could use 'dirs' and 'files'
   to select the directories and files they want to package.

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
       cat > /etc/yum.repos.d/test.repo <<EOF
       [appsdk-test-repo]
       name=appsdk test repo
       baseurl=http://HOST_IP:8888/third_party_repo/
       gpgcheck=0
       EOF

   4b) Enter development mode, get a writable filesystem
       ostree admin unlock --hotfix

   4c) Install hello package
       dnf install hello

   4d) Run hello program

       e.g.
       root@intel-x86-64:~# hello
       Hello, world!

5. Use the RPM package as input of 'appsdk genimage' and 'appsdk gensdk`

   5a) Modify yaml file

       Add 'http://HOST_IP:8888/third_party_repo/' to package_feeds section.
       Add 'hello' to external-packages section.

       e.g.1 Manually edit image-with-hello-intel-x86-64.yaml
       name: image-with-hello
       package_feeds:
       - http://<web-server-url>/lat/WRLinux-CD-Images/intel-x86-64/repos/rpm/noarch/
       - http://<web-server-url>/lat/WRLinux-CD-Images/intel-x86-64/repos/rpm/corei7_64/
       - http://<web-server-url>/lat/WRLinux-CD-Images/intel-x86-64/repos/rpm/intel_x86_64/
       - http://HOST_IP:8888/third_party_repo
       external-packages:
       - hello

       e.g.2 Run genyaml to generate image-with-hello-intel-x86-64.yaml
       genyaml --url http://HOST_IP:8888/third_party_repo --pkg-external hello --name image-with-hello

    5b) appsdk genimage --type all image-with-hello-intel-x86-64.yaml
        appsdk gensdk -f image-with-hello-intel-x86-64.yaml

```
Check environment-setup-*-wrs-linux for the exported variables.

## System Definition
### Abstract
The goal of the System Definition is to provide a way to define and
implement system configuration changes that goes beyond those
configurations shipped in individual software packages. These can
include, but are not limited to:
 * System configurations, such as hostname and IP
 * Containers images and configurations
 * User accounts and configurations
 * Vendor data
 * Cloud data

### Limitation
Only apply system definition on ustart/wic/vmdk/vdi image (generated
by appsdk genimage), the initramfs image and container image do not
support it

### YAML
#### YAML Design
* The current Linux Assembly Tool YAML schema should be enhanced
  with a 'system' top level list tag. List elements can be 'run_once',
  'run_on_upgrade', 'run_always', 'files' and 'contains'.

* The 'system: files' tag should be a list of 'file' elements.

* The 'system: files: file' tag should each define a mode, source
  and destination.

* The 'system: run_once' tag should be a list of script file sources.
  Each of these will be copied to a location in /etc where system
  definition tools will run them once after installation.

* The 'system: run_on_upgrade' tag should be a list of script file
  sources. Each of these will be copied to a location in /etc where
  system definition tools will run them once after installation, and
  once after each upgrade. In order to track script updates there will
  be a new directory in /etc for each upgrade containing the copies of
  the scripts included in that upgrade bundle.

* The 'system: run_always' tag should be a list of script file
  sources. Each of these will be copied to a location in /etc where
  system definition tools will run each script on each reboot.

* The 'system: contains' tag should be a list of system YAML files
  and acts as an include for other system specification files. In
  this way we can define a nesting of systems. For example this
  would allow us to define a Xen top level system along with the
  contained VMs. We will only support one level of nesting, so a
  contained YAML can not definie a 'contains' of its own. The
  'contains' tag will only be valid for image types ('ustart',
  'wic', 'vmdk' and 'vdi'), for example a 'container' image must not
  use the 'contains' tag, and should throw an ERROR.

#### YAML Example
Run 'appsdk exampleyamls' to get a set of pre-canned scripts are made
available as part of the Linux Assembly Tool with the ability to add
new ones as time and need demands.
```
$ tree exampleyamls/sysdef/
exampleyamls/sysdef/
|-- add-system-user.yaml
|-- add-user-home.yaml
|-- contains-container-base.yaml
|-- files
|   |-- docker_daemon.jason
|   |-- sudoers_sudo
|   `-- windriver_dns.conf
|-- run_always.d
|   '-- 10_start_containers.sh
|-- run_on_upgrade.d
|   |-- 10_update_containers.sh
|   `-- containers.dat
|-- run_once.d
|   |-- 10_add_system_user.sh
|   |-- 20_add_user_home.sh
|   |-- 30_set_hostname.sh
|   `-- 40_set_ntp.sh
|-- set-dns.yaml
|-- set-hostname.yaml
|-- set-ntp.yaml
`-- update-containers.yaml
```

The first set of scripts includes:

  * the script that adds a new user to the system
    See exampleyamls/sysdef/add-system-user.yaml

  * the script that adds a new user and home directory
    See exampleyamls/sysdef/add-user-home.yaml

  * the script that sets the hostname based on an system attribute such
    as the MAC address
    See exampleyamls/sysdef/set-hostname.yaml

  * a set of the scripts that pulls listed containers (from containers.dat)
    from a public registrey and runs them. This should replace the
    existing 'include-container-images' functionality.
    See exampleyamls/sysdef/update-containers.yaml

  * the script that set the DNS resolver to a given IP
    See exampleyamls/sysdef/set-dns.yaml

  * the script that updates the address of the ntp server
    See exampleyamls/sysdef/set-ntp.yaml

  * The yaml that generates an image which contains a sub container image,
    a nest build will be run ahead of the main build
    See contains-container-base.yaml

The customer should refer these yamls and scripts to manipulate
their own, take exampleyamls/sysdef/add-system-user.yaml for example,
the yaml inclues a run_once script exampleyamls/sysdef/run_once.d/10_add_system_user.sh,
in which it calls 'useradd' at target first boot to ceate a system user
with username 'system-user' and password '123456'. Customer could
create their own user and password base on the example

### Runtime Tool: sysdef.sh
A new tool 'sysdef.sh' is written to implement the runtime functionality
of the System Definition.
```
      $ sysdef.sh -h
      usage: sysdef.sh [-f] [-v] |run-once|run-on-upgrade|run-always [script1] [script2] [...]
           sysdef.sh [-f] [-v] run-all
           sysdef.sh [-v] list
               -f: ignore stamp, force to run
               -v: verbose
```

- In order to run sysdef.sh automatically when included in an image,
  a systemd service 'sysdef.service' ensures the sysdef.sh be run at
  a suitable time during boot. Maximum 3 times rerun if the service
  failed.
```
      $ systemctl status sysdef.service
      * sysdef.service - A tool to implement the runtime functionality of the System Definition.
           Loaded: loaded (/usr/lib/systemd/system/sysdef.service; enabled; vendor preset: disabled)
           Active: active (exited) since Mon 2020-11-23 07:53:30 UTC; 1h 8min ago
          Process: 329 ExecStart=/usr/bin/sysdef.sh run-all (code=exited, status=0/SUCCESS)
         Main PID: 329 (code=exited, status=0/SUCCESS)
```

- Log (/var/log/syslog) is captured for the tool and each of the scripts
  it runs.
```
      $ grep sysdef /var/log/syslog
      2020-11-23T07:52:54.216341+00:00 intel-x86-64 sysdef.sh[329]: Start run-once 10_add_system_user.sh
      2020-11-23T07:52:54.220970+00:00 intel-x86-64 sysdef.sh[329]: Run run-once 10_add_system_user.sh success
      2020-11-23T07:52:54.222146+00:00 intel-x86-64 sysdef.sh[329]: Start run-once 20_add_user_home.sh
      ...
```

- It handles failures gracefully. If a single script fails the remaining
  scripts should still be run.

- It makes use of stamp files to prevent run once scripts from being
  run multiple times. The scripts in each type (run_once/run_always/
  run_on_upgrade)) are in alphanumeric order, allowing the user to
  specify the order in which scripts are run.
```
      /etc/sysdef/
        run_once.d/
            10_add_system_user.sh
            10_add_system_user.sh.stamp
            20_add_user_home.sh
            20_add_user_home.sh.stamp
            30_set_hostname.sh
            30_set_hostname.sh.stamp
            40_set_ntp.sh
            40_set_ntp.sh.stamp
        run_always.d/
            10_start_containers.sh
        run_on_upgrade.d/
            15082020025600//
                10_update_containers.sh
                10_update_containers.sh.stamp
                containers.dat
            20201123074928/
                10_update_containers.sh
                10_update_containers.sh.stamp
                containers.dat
```

- Support to run manually, it provides options '-f' to ignore the
  stamp files (not by default though).

  List all scripts in run:
```
      $ sysdef.sh list
      run-once
          10_add_system_user.sh
          10_add_system_user.sh.stamp
          20_add_user_home.sh
          20_add_user_home.sh.stamp
          30_set_hostname.sh
          30_set_hostname.sh.stamp
          40_set_ntp.sh
          40_set_ntp.sh.stamp
      run-on-upgrade(20201123074928)
          10_update_containers.sh
          10_update_containers.sh.stamp
          containers.dat
      run-always
          10_start_containers.sh
```

  Rerun all sysdef scripts manually:
```
      $ sysdef.sh -f run-all
      Start run-once 10_add_system_user.sh
      useradd: user 'system-user' already exists
      Run run-once 10_add_system_user.sh failed
      ...
```

  Rerun specific sysdef scripts manually:
```
      $ sysdef.sh -f run-on-upgrade 10_update_containers.sh
      Start run-on-upgrade(20201123074928) 10_update_containers.sh
      ...
      Run run-on-upgrade(20201123074928) 10_update_containers.sh success
```

### Support Long Lived Containers with docker

#### Long Live Containers Functions
- Load docker image by docker load
- Import filesystem tarball by docker import
- Pull docker image from registry
- Run multiple containers from one image
- Run container with user define docker run option
- Run container with user define docker command
- Start container automatically while system boot
- Stop container gracefully while system shutdown
- Update containers while system upgrade

#### Long Live Containers Implement
Provides two scripts and one data file in exampleyamls

    exampleyamls/sysdef/run_always.d
        10_start_containers.sh
    exampleyamls/sysdef/run_on_upgrade.d
        containers.dat
        10_update_containers.sh


Each line in containers.dat records how to load/import/pull and run a container
The format of line is:
```
The '<container-name>' is mandatory, it is the name of container (docker run --name <container-name> XXX);
If 'load=<docker-image-tarball>' is set, use 'docker load' to add image tarball;
If 'import=<fs-tarball>' is set, use 'docker import' to add filesystem tarball;
If no 'load=<docker-image-tarball>' and no 'import=<fs-tarball>', use 'docker pull' to add image;
The 'image=<container-image-name>' is optional, if not set, use '<container-name>' by default;
The 'run-opt=<docker-run-opt>' is optional, if not set, use '-itd' by default (docker run -itd XXX);
The 'run-cmd=<docker-run-cmd>' is optional, if not set, default is empty
Examples:
  ubuntu
    ->        docker pull ubuntu
    ->        docker run --name ubuntu ubuntu
    ->        systemctl start start-container@ubuntu.service

  ubuntu-bash image=ubuntu run-opt="-p 2224:22 -it" run-cmd=/bin/bash
    ->        docker pull ubuntu
    ->        docker run -p 2224:22 -it -d --name ubuntu-bash ubuntu /bin/bash
    ->        systemctl start start-container@ubuntu-bash.service

  wrlinux-image-full import=/var/docker-images/wrlinux-image-full-intel-x86-64.tar.bz2 run-cmd=/bin/sh
    ->        docker import /var/docker-images/wrlinux-image-full-intel-x86-64.tar.bz2 wrlinux-image-full
    ->        docker run -itd --name wrlinux-image-full wrlinux-image-full /bin/sh
    ->        systemctl start start-container@wrlinux-image-full.service

  container-base load=/var/docker-images/container-base-intel-x86-64.docker-image.tar.bz2
    ->        docker load -i /var/docker-images/container-base-intel-x86-64.docker-image.tar.bz2
    ->        docker run -itd --name container-base
    ->        systemctl start start-container@container-base.service
```

#### Long Live Containers Work Flow
Usually the following Steps are required for customer
1) Run 'appsdk exampleyamls' to prepare yamls and scripts

2) If use docker to load image or import filesystem tarball, make these
files be available on host or web server. If use docker to pull image,
this step is ignored

3) Manipulate Yaml file:
- Set image type with "ustart" or "wic" to avoid the yaml was incorrectly
  parsed by geninitramfs or gencontainer

- Use "packages" tag to install dependency packages 'startup-container'
  and 'docker'

- If use docker to load image or import filesystem tarball, make use of
  "system:file" tag or "rootfs-post-scripts" tag to copy files to target
  rootfs. If use docker to pull image, this step is ignored

- Use "system:run_always" tag and "system:run_on_upgrade" tag to install
  scripts 10_start_containers.sh and 10_update_containers.sh from exampleyamls
  to target rootfs

- Use "rootfs-post-scripts" tag to add settings as described above to
  containers.dat, one line for one container

4) Use 3)'s yaml file as input, run 'appsdk genimage' to generate image

#### Long Live Containers Examples
An example from exampleyamls/sysdef/update-containers.yaml which pulls
ubuntu image from public registry, and run two containers from the
ubuntu image, one with default option and command, one with user
define option and command.
```
  # - At a boot after upgrade, pulls listed containers (from containers.dat)
  #   from a public registrey and runs them.
  # - At each boot, start listed containers (from containers.dat)
  # - Two containers in containers.dat: hello-world and ubuntu
  # - Add a docker_daemon.jason to set private insecure registries of Wind River
  image_type:
  - ostree-repo
  - ustart
  packages:
  - startup-container
  - docker
  rootfs-post-scripts:
  - echo "ubuntu" >> $IMAGE_ROOTFS/etc/sysdef/run_on_upgrade.d/containers.dat
  - echo "ubuntu-bash image=ubuntu run-opt="-p 2224:22 -it" run-cmd=/bin/bash" >> $IMAGE_ROOTFS/etc/sysdef/run_on_upgrade.d/containers.dat
  system:
  - run_on_upgrade:
    - exampleyamls/sysdef/run_on_upgrade.d/10_update_containers.sh
  - run_always:
    - exampleyamls/sysdef/run_always.d/10_start_containers.sh
  - files:
    - file:
        src: exampleyamls/sysdef/files/docker_daemon.jason
        dst: /etc/docker/daemon.json
        mode: 644
    - file:
        src: exampleyamls/sysdef/run_on_upgrade.d/containers.dat
        dst: /etc/sysdef/run_on_upgrade.d/
        mode: 644
```

An example from exampleyamls/feature/startup-container.yaml, there are
three images, one is a docker image which was generated by 'appsdk
gencontainer', it will be used by docker load; one is a filesystem
tarball which is downloaded from web server, it will be used by docker
import; one is a docker image which is downloaded from private regristry
by command 'skopeo copy', it will be used by docker load
```
  packages:
  - startup-container
  - docker
  rootfs-post-scripts:
  - echo "container-base load=/var/docker-images/container-base-intel-x86-64.docker-image.tar.bz2 image=container-base-intel-x86-64"  >> $IMAGE_ROOTFS/etc/sysdef/run_on_upgrade.d/containers.dat
  - echo "ubuntu-tar load=/var/docker-images/ubuntu.docker-image.tar.bz2" >> $IMAGE_ROOTFS/etc/sysdef/run_on_upgrade.d/containers.dat
  - echo "wrlinux-image-full import=/var/docker-images/wrlinux-image-full-intel-x86-64.tar.bz2 run-cmd=/bin/sh" >> $IMAGE_ROOTFS/etc/sysdef/run_on_upgrade.d/containers.dat
  - skopeo copy --src-tls-verify=false --insecure-policy docker://pek-lpdfs01:5000/ubuntu docker-archive:$IMAGE_ROOTFS/var/docker-images/ubuntu.docker-image.tar.bz2:ubuntu-tar
  system:
  - run_on_upgrade:
    - exampleyamls/sysdef/run_on_upgrade.d/10_update_containers.sh
  - run_always:
    - exampleyamls/sysdef/run_always.d/10_start_containers.sh
  - files:
    - file:
        src: deploy/container-base-intel-x86-64.docker-image.tar.bz2
        dst: /var/docker-images/
        mode: 644
    - file:
        src: http://pek-lpgtest7302.wrs.com/buildarea1/SharedImage/LINCD_STD_BINARY/intel-x86-64/latest/WRLinux-CD-Images/intel-x86-64/container-full-intel-x86-64/wrlinux-image-full-intel-x86-64.tar.bz2
        dst: /var/docker-images/
        mode: 644
```

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
