# Generate binary images
This tool can generate binary images and make them ready for deployment. It
must be run in a build environment.

## Usage
- setup a project with --all-layers
- Initial a build
- $ gen-image -m <machine>
- See gen-image --help for more info

## Output
The output files are in outdir/dist/

## conf/local.conf and conf/local.conf.orig
If it is a fresh build, the tool will copy conf/local.conf to
conf/local.conf.orig for later using, if not, it copies conf/local.conf.orig to
conf/local.conf and use it for the current build.

## Define PACKAGE_FEED_URIS
Specifies the front portion of the package feed URI used by the OpenEmbedded
build system. It will be used by both packages feed and and ostree repo.

For example:
PACKAGE_FEED_URIS  = "http://127.0.0.1/path/to/repos"

There are two ways to define it:
- If there is a conf/local.conf.orig, define it there
- If not, define it in conf/local.conf
