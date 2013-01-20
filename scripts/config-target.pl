#!/usr/bin/perl
#  Copyright (c) 2005-2008,2010-2012 Wind River Systems, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

use strict;
use File::Copy;
use Cwd;

### Compute TOP_BUILD_DIR ###
our $progroot = $0;
our $orig_progroot = "";

my $cwd;
if ($progroot !~ /^\//) {
  $cwd = getcwd();
  $progroot = "$cwd/./$progroot";
}
while ($progroot =~ /\/\.\//) {
  $progroot =~ s/\/\.\//\//;
}
while ($progroot =~ /\/[^\/]*?\/\.\.\//) {
  $progroot =~ s/(\/[^\/]*?\/\.\.\/)/\//;
}
$progroot =~ s/^\/\.\.\//\//;
#chop off the program name
$progroot =~ s/^(.*)\/.*/$1/;
# Compute the top name which is roughly ..
$progroot .= "/../";
# In the bitbake world the progroot is the directory above the bitbake_build
if ($ENV{'BUILDDIR'} ne "") {
  $orig_progroot = $progroot;
  $progroot = "$ENV{'BUILDDIR'}/../" if ($ENV{'BUILDDIR'} ne "");
}
while ($progroot =~ /\/[^\/]*?\/\.\.\//) {
  $progroot =~ s/(\/[^\/]*?\/\.\.\/)/\//;
}
# And finally remove the trailing slash
$progroot =~ s/\/$//;

# Set base path depending on qemu location
our $BPATH = "$progroot/host-cross/bin";
if (-x "$progroot/host-cross/usr/bin/qemu") {
  $BPATH = "$progroot/host-cross/usr/bin";
}
if ($ENV{'BUILD_BIN_DIR'} ne "") {
  $BPATH = $ENV{'BUILD_BIN_DIR'}
}

our $CROSSPATH = "$progroot/host-cross";
if ($ENV{'HOST_CROSS_SYSROOT_DIR'} ne "") {
  $CROSSPATH = $ENV{'HOST_CROSS_SYSROOT_DIR'}
}


$ENV{'TOP_BUILD_DIR'} = $progroot;
my $debug = 0;
print "Program root: $progroot\n" if $debug;
### END Compute TOP_BUILD_DIR ###

my $config_file = "$progroot/config.sh";
if ($ENV{'TARGET_CONFIG_FILE'} ne "") {
  $config_file = $ENV{'TARGET_CONFIG_FILE'}
}
my %supported_types;
our $virt_type = "";
my $instance = 0;
our @tgt_confs;
our %tgt_vars;
our $use_taskset = 1;

sub setup_makefile_vars {
  my $toparse = "$progroot/Makefile";
  # For bitbake search for local.conf
  my $bbconf = "$progroot/bitbake_build/conf/local.conf";
  if (-e $bbconf) {
    $tgt_vars{'TOP_PRODUCT_DIR'} = "$progroot/..";
  } 

  if (!(-e $config_file) && (-e $bbconf)) {
    my $mach = "";
    my $fstype = "";
    open(VAR, $bbconf) || die "Could not open: $bbconf";
    while($_ = <VAR>) {
      chop();
      if ($_ =~ /^\s*MACHINE\s*=\s*(\S+)/) {
	$mach = $1;
	$mach =~ s/\"//g;
      }
      if ($_ =~ /^\s*DEFAULT_IMAGE\s*=\s*(\S+)/) {
	$fstype = $1;
	$fstype =~ s/\"//g;
      }
    }
    close(VAR);
    my $bbfile = "$progroot/bitbake_build/tmp/deploy/images/config-vars-$fstype-$mach";
    if (-e $bbfile) {
      copy($bbfile, $config_file);
    } else {
      print "ERROR: could not find: $bbfile\n";
      print "       Perhaps you need to build the root filesystem?\n";
      exit 1;
    }
  }

  open(VAR, "$toparse");
  while (<VAR>) {
    if (($_ =~ /^(PACKAGE_.*?) = (.*)/) ||
	($_ =~ /^(TOP_.*?) = (.*)/) ||
	($_ =~ /^(TARGET_KERNEL.*?) = (.*)/) ||
	($_ =~ /^(LAYER_DIRS_.*?) = (.*)/) ||
	($_ =~ /^(TARGET_ROOTFS.*?) = (.*)/) ||
	($_ =~ /^(TARGET_BOARD.*?) = (.*)/) ||
	($_ =~ /^(TARGET_BOARD)=\"(.*?)\"/)) {
      my $a = $1;
      my $b = $2;
      $b =~ s/^\"//;
      $b =~ s/\"$//;
      if (exists($ENV{$a})) {
	$tgt_vars{$a} = $ENV{$a};
      } else {
	$tgt_vars{$a} = $b;
      }
      print "Read from Makefile: $a == $b\n" if $debug;
    }
    chop;
  }
  close(VAR);
}

setup_makefile_vars();

## Detect te availble simulators
our $got_simics = 0;
our $got_qemu = 0;
our $got_uml = 0;
our $simics_dir = find_simics_dir();
simTypeAvailable();

## Source in simics from the layer
if ($simics_dir ne "") {
  require "$simics_dir/config-target-simics.pl";
  Simics->import;
} else {
eval '
sub do_startvmp {
  print "ERROR: missing config-target-simics.pl\n";
  exit 1;
}
sub simics_start {
  print "ERROR: missing config-target-simics.pl\n";
  exit 1;
} ';
}

# Select a BSP
bspDetect();
## Format of the tgt_confs array is
# [ ENV_KEY, Description, default value, field type, regex validator, options list ]
if ($virt_type eq "qemu") {
@tgt_confs = (
[ "TARGET_VIRT_BOOT_TYPE", "Boot type", "usernfs", "Choice", "", "usernfs;cdrom;disk"],
[ "NFS_EXPORT_DIR","NFS Export Directory","", "Directory", "", ""],
[ "NFS_MOUNT_DIR","NFS Export Directory","export/dist", "String", "", ""],
[ "NFS_MOUNTPROG","rpc.mountd RPC port","21111", "Long", "", ""],
[ "NFS_NFSPROG","rpc.nfsd RPC port","11111", "Long", "", ""],
[ "NFS_PORT","NFS port number","3049", "String", "", ""],
[ "MOUNT_PORT","NFS mountd port number","3048", "String", "", ""],
[ "TARGET_VIRT_CPU_MASK","Argument to taskset for localizing simulator [auto,none,##]", "auto","String","",""],
[ "TARGET_VIRT_ENET_TYPE" , "Enet Type[slirp,slirpvde,tuntap]", "slirp", "Choice", "", "slirp;slirpvde;tuntap"],
[ "TARGET_TAP_DEV", "Tap device [auto,tap0,tap1...]", "auto", "String", "", ""],
[ "TARGET_TAP_UID", "Tap device owner UID", "default", "String", "", ""],
[ "TARGET_TAP_IP", "IP Address of Tap interface or 'auto'", "auto", "String", "", ""],
[ "TARGET_TAP_ROOTACCESS", "Root access command for tap [su -c,sudo]", "sudo", "String", "", ""],
[ "TARGET_TAP_HOST_DEV", "Host TAP ethernet interface", "eth0", "String", "", ""],
[ "TARGET_TAP_ETH_DEV", "Target TAP ethernet interface", "eth0", "String", "", ""],
[ "TARGET_VDE_DIR", "Use a shared VDE Socket Directory", "", "String", "", ""],
[ "TARGET_VDE_SLIRP_OPTS", "Override VDE Slirp options", "", "String", "", ""],
[ "TARGET_VDE_ESLIRP_OPTS", "Extra VDE Slirp options", "", "String", "", ""],
[ "TARGET_QEMU_BIN", "QEMU binary to use", "", "String", "", ""],
[ "TARGET_VIRT_IP", "IP addres or [auto,dhcp,none]", "auto", "String", "", ""],
[ "TARGET_VIRT_GATEWAY", "Gateway when dhcp not in use", "10.0.2.2", "String", "", ""],
[ "TARGET_VIRT_NETMASK", "Netmask when dhcp not in use", "255.255.255.0", "String", "", ""],
[ "TARGET_VIRT_MAC", "Default MAC Addr", "52:54:00:12:34:56", "String", "", ""],
[ "TARGET_QEMU_ENET_MODEL" , "Use a specific enet card ie: [auto,rtl8139,ne2k_pci,...]", "auto", "String", "", ""],
[ "TARGET_QEMU_USE_STDIO", "Use stdio as the default cdevice", "yes", "String", "", ""],
[ "TARGET_QEMU_BOOT_CONSOLE", "Console device", "ttyS0,115200", "String", "", ""],
[ "TARGET_QEMU_MEM", "Megs of memory to request [default,#]", "default", "String", "", ""],
[ "TARGET_QEMU_SMP","The number of cores to allocate in the target [0 = default]","0", "Long", "", ""],
[ "TARGET_QEMU_GRAPHICS", "Enable Graphics", "no", "String", "", ""],
[ "TARGET_QEMU_KEYBOARD", "Keyboard type", "en-us", "String", "", ""],
[ "TARGET_QEMU_PROXY_PORT", "Console proxy port for telnet", "4442", "Long", "", ""],
[ "TARGET_QEMU_PROXY_LISTEN_PORT", "Console proxy port qemu backend", "4446", "Long", "", ""],
[ "TARGET_QEMU_DEBUG_PORT" , "QEMU ICE style debug port", "1234", "Long", "", ""],
[ "TARGET_QEMU_AGENT_RPORT" , "usermode-agent port", "udp:4444::17185", "String", "", ""],
[ "TARGET_QEMU_TCF_RPORT" , "tcf-agent tcp port", "tcp:4447::1534", "String", "", ""],
[ "TARGET_QEMU_UTCF_RPORT" , "tcf-agent udp port", "udp:4447::1534", "String", "", ""],
[ "TARGET_QEMU_HTTP_RPORT" , "HTTP web port", "tcp:4448::80", "String", "", ""],
[ "TARGET_QEMU_KGDB_RPORT" , "KGDB port", "udp:4445::6443", "String", "", ""],
[ "TARGET_QEMU_TELNET_RPORT" , "Telnet port", "tcp:4441::23", "String", "", ""],
[ "TARGET_QEMU_SSH_RPORT" , "ssh port", "tcp:4440::22", "String", "", ""],
[ "TARGET_QEMU_MEMORYANALYZER_RPORT" , "Memory Analyzer port", "tcp:5698::5698", "String", "", ""],
[ "TARGET_QEMU_PERFORMANCEPROFILER_RPORT" , "Performance Profiler port", "tcp:5678::5678", "String", "", ""],
[ "TARGET_QEMU_CODECOVERAGEANALYZER_RPORT" , "Code Coverage Analyzer port", "tcp:3333::3333", "String", "", ""],
[ "TARGET_QEMU_STETHOSCOPE_0_RPORT" , "StethoScope index 0 port","tcp:49152::49152", "String", "", ""],
[ "TARGET_QEMU_STETHOSCOPE_1_RPORT" , "StethoScope index 1 port","tcp:49153::49153", "String", "", ""],
[ "TARGET_QEMU_STETHOSCOPE_2_RPORT" , "StethoScope index 2 port","tcp:49154::49154", "String", "", ""],
[ "TARGET_QEMU_STETHOSCOPE_3_RPORT" , "StethoScope index 3 port","tcp:49155::49155", "String", "", ""],
[ "TARGET_QEMU_STETHOSCOPE_4_RPORT" , "StethoScope index 4 port","tcp:49156::49156", "String", "", ""],
[ "TARGET_QEMU_STETHOSCOPE_SIGINSTALL_0_RPORT" , "StethoScope index signal install 0 port", "tcp:49280::49280", "String", "", ""],
[ "TARGET_QEMU_STETHOSCOPE_SIGINSTALL_1_RPORT" , "StethoScope index signal install 1 port", "tcp:49281::49281", "String", "", ""],
[ "TARGET_QEMU_STETHOSCOPE_SIGINSTALL_2_RPORT" , "StethoScope index signal install 2 port", "tcp:49282::49282", "String", "", ""],
[ "TARGET_QEMU_STETHOSCOPE_SIGINSTALL_3_RPORT" , "StethoScope index signal install 3 port", "tcp:49283::49283", "String", "", ""],
[ "TARGET_QEMU_STETHOSCOPE_SIGINSTALL_4_RPORT" , "StethoScope index signal install 4 port", "tcp:49284::49284", "String", "", ""],
[ "TARGET_QEMU_KERNEL", "Absolute kernel location or kernel to search for", "bzImage", "String", "", ""],
[ "TARGET_QEMU_CPU", "Use an alternate qemu cpu", "", "String", "", ""],
[ "TARGET_QEMU_INITRD", "Initrd iamge", "", "String", "", ""],
[ "TARGET_VIRT_DISK", "Hard disk image", "", "String", "", ""],
[ "TARGET_VIRT_DISK_UNIT", "Hard disk unit for root file system", "", "String", "", ""],
[ "TARGET_VIRT_CDROM", "CDROM", "", "String", "", ""],
[ "TARGET_VIRT_ROOT_MOUNT", "How to mount the root file system [rw,ro]", "rw", "String", "", ""],
[ "TARGET_QEMU_BOOT_DEVICE", "Default boot device", "", "String", "", ""],
[ "TARGET_QEMU_KERNEL_OPTS", "Extra Kernel Options", "", "String", "", ""],
[ "TARGET_VIRT_UMA_START", "Start usermode agent on boot", "yes", "String", "", ""],
[ "TARGET_QEMU_OPTS" , "Extra QEMU Options", "", "String", "", ""],
[ "TARGET_VIRT_EXT_WINDOW", "Use the external window to spawn the target", "no", "String", "", ""],
[ "TARGET_VIRT_EXT_CON_CMD" , "Application for extneral console", "xterm -T Virtual-WRLinux -e", "String", "", ""],
[ "TARGET_VIRT_CONSOLE_SLEEP" , "Sleep for # seconds on external console after exit", "5", "String", "", ""],
[ "TARGET_QEMU_HOSTNAME" , "Use a non default hostname", "", "String", "", ""],
[ "TARGET_VIRT_DEBUG_WAIT", "Wait for debugger to attach", "no", "String", "", ""],
[ "TARGET_VIRT_DEBUG_TIMEOUT_DEFAULT", "Default timeout for debugger to wait for target to boot", "40", "Long", "", ""],
);
} elsif ($virt_type eq "uml") {
@tgt_confs = (
[ "TARGET_VIRT_BOOT_TYPE" , "Boot type", "usernfs"],
[ "NFS_EXPORT_DIR","NFS Export Directory","" ],
[ "NFS_MOUNT_DIR","NFS Export Directory","export/dist" ],
[ "NFS_MOUNTPROG","rpc.mountd RPC port","21111" ],
[ "NFS_NFSPROG","rpc.nfsd RPC port","11111" ],
[ "NFS_PORT","NFS port number","3049" ],
[ "MOUNT_PORT","NFS mountd port number","3048", "String", "", ""],
[ "TARGET_VIRT_ENET_TYPE" , "Enet Type[slirpvde,tuntap]", "slirpvde"],
[ "TARGET_TAP_DEV", "Tap device [auto,tap0,tap1...]", "auto" ],
[ "TARGET_TAP_UID", "Tap device owner UID", "default" ],
[ "TARGET_TAP_IP", "IP Address of Tap interface or 'auto'", "auto" ],
[ "TARGET_TAP_ROOTACCESS", "Root access command for tap [su -c,sudo]", "sudo" ],
[ "TARGET_TAP_HOST_DEV", "Host TAP ethernet interface", "eth0" ],
[ "TARGET_TAP_ETH_DEV", "Target TAP ethernet interface", "eth0" ],
[ "TARGET_VDE_DIR", "Use a shared VDE Socket Directory", "" ],
[ "TARGET_VDE_SLIRP_OPTS", "Override VDE Slirp options", "" ],
[ "TARGET_VDE_ESLIRP_OPTS", "Extra VDE Slirp options", "" ],
[ "TARGET_VIRT_IP", "IP addres or [auto,dhcp,none]", "auto" ],
[ "TARGET_VIRT_GATEWAY", "Gateway when dhcp not in use", "10.0.2.2" ],
[ "TARGET_VIRT_NETMASK", "Netmask when dhcp not in use", "255.255.255.0" ],
[ "TARGET_VIRT_MAC", "Default MAC Addr", "FE:FD:00:00:00:00" ],
[ "TARGET_UML_USE_STDIO", "Use stdio as the default cdevice", "yes" ],
[ "TARGET_UML_BOOT_CONSOLE", "Console device", "tty0" ],
[ "TARGET_UML_MEM", "Megs of memory to request [default,#]", "default" ],
[ "TARGET_UML_GRAPHICS", "Enable Graphics", "no" ],
[ "TARGET_UML_KEYBOARD", "Keyboard type", "en-us" ],
[ "TARGET_UML_PROXY_PORT", "Console proxy port for telnet", "4442"],
[ "TARGET_UML_PROXY_LISTEN_PORT", "Console proxy port qemu backend", "4446"],
[ "TARGET_UML_DEBUG_PORT" , "UML ICE style debug port", "1234"],
[ "TARGET_UML_AGENT_RPORT" , "usermode-agent port", "udp:4444:10.0.2.15:17185"],
[ "TARGET_UML_TCF_RPORT" , "tcf-agent port", "1534:10.0.2.15:1534", "String", "", ""],
[ "TARGET_UML_TELNET_RPORT" , "Telnet port", "4441:10.0.2.15:23"],
[ "TARGET_UML_SSH_RPORT" , "ssh port", "4440:10.0.2.15:22"],
[ "TARGET_UML_MEMORYANALYZER_RPORT" , "Memory Analyzer port", "5698:10.0.2.15:5698"],
[ "TARGET_UML_PERFORMANCEPROFILER_RPORT" , "Performance Profiler port", "5678:10.0.2.15:5678"],
[ "TARGET_UML_CODECOVERAGEANALYZER_RPORT" , "Code Coverage Analyzer port", "tcp:3333:10.0.2.15:3333", "String", "", ""],
[ "TARGET_UML_KERNEL", "Absolute kernel location or kernel to search for", "vmlinux" ],
[ "TARGET_UML_INITRD", "Initrd iamge", "" ],
[ "TARGET_UML_COW", "COW file", "" ],
[ "TARGET_VIRT_DISK", "Hard disk image", "" ],
[ "TARGET_VIRT_ROOT_MOUNT", "How to mount the root file system [rw,ro]", "rw", "String", "", ""],
[ "TARGET_UML_BOOT_DEVICE", "Default boot device", "" ],
[ "TARGET_UML_KERNEL_OPTS", "Extra Kernel Options", "" ],
[ "TARGET_VIRT_UMA_START", "Start usermode agent on boot", "yes", "String", "", ""],
[ "TARGET_UML_OPTS" , "Extra UML Options", ""],
[ "TARGET_VIRT_EXT_WINDOW", "Use the external window to spawn the target", "no"],
[ "TARGET_VIRT_EXT_CON_CMD" , "Application for extneral console", "xterm -T VIRTUAL-WRLinux -e"],
[ "TARGET_VIRT_CONSOLE_SLEEP" , "Sleep for # seconds on external console after exit", "5"],
[ "TARGET_UML_HOSTNAME" , "Use a non default hostname", ""],
[ "TARGET_VIRT_DEBUG_TIMEOUT_DEFAULT", "Default timeout for debugger to wait for target to boot", "40", "Long", "", ""],
);
}

my $arp = "/sbin/arp";
my $dostart = 0;
our $dostartvmp = 0;
my $dostop = 0;
my $donetstart = 0;
my $donetstop = 0;
my $donfsstart = 0;
my $dostatus = 0;
my $donfsstop = 0;
my $doallstop = 0;
my $doallstop = 0;
my $doconfig = 0;
my $foreground = 1;
my $doinc = 0;
our $doOutputStart = 0;
my $useSU = 0;
my $diskboot = "";
my $isoboot = "";
my $cowfile = "";
my $xmlout = 0;
my $xmlin = 0;
my $partition = "";
my $nokernel = 0;
my $firstdev = "";
my $root = "";

### Parse Arguments ###
# look for TARGET_TOPTS in the environment,
# use TARGET_TOPTS if it's set and TOPTS isn't.
if (@ARGV < 1) {
  do_usage();
} elsif (@ARGV == 1 && $ENV{'TARGET_TOPTS'}) {
  push @ARGV, split(/\s+/, $ENV{'TARGET_TOPTS'});
}

while ($ARGV[0]) {
  if ($ARGV[0] eq "-c") {
    $ENV{'TARGET_QEMU_USE_STDIO'} = "yes";
  } elsif ($ARGV[0] eq "-g") {
    $ENV{'TARGET_QEMU_GRAPHICS'} = "yes";
    $ENV{'TARGET_SIMICS_GRAPHICS'} = "yes";
  } elsif ($ARGV[0] eq "-gc") {
    $ENV{'TARGET_QEMU_GRAPHICS'} = "yes";
    $ENV{'TARGET_SIMICS_GRAPHICS'} = "yes";
    $ENV{'TARGET_QEMU_BOOT_CONSOLE'} = "tty0";
    $ENV{'TARGET_SIMICS_BOOT_CONSOLE'} = "tty0";
  } elsif ($ARGV[0] eq "-p") {
    $ENV{'TARGET_QEMU_USE_STDIO'} = "no";
  } elsif ($ARGV[0] eq "-x") {
    $ENV{'TARGET_VIRT_EXT_WINDOW'} = "yes";
  } elsif ($ARGV[0] eq "-o") {
    $doOutputStart = 1;
  } elsif ($ARGV[0] eq "-w") {
    $ENV{'TARGET_VIRT_DEBUG_WAIT'} = "yes";
  } elsif ($ARGV[0] eq "-su") {
    $useSU = 1;
  } elsif ($ARGV[0] eq "-m") {
    $ENV{'TARGET_UML_MEM'} = $ARGV[1];
    $ENV{'TARGET_QEMU_MEM'} = $ARGV[1];
    shift @ARGV;
  } elsif ($ARGV[0] eq "-no-kernel") {
    $nokernel = 1;
  } elsif ($ARGV[0] eq "-root") {
    $root = $ARGV[1];
    shift @ARGV;
  } elsif ($ARGV[0] eq "-cd") {
    $isoboot = $ARGV[1];
    if ($firstdev eq "") {
      $firstdev = "cdrom"
    }
    shift @ARGV;
  } elsif ($ARGV[0] eq "-xmlout") {
    $xmlout = 1;
  } elsif ($ARGV[0] eq "-xmlin") {
    $xmlin = 1;
  } elsif ($ARGV[0] eq "-disk") {
    $diskboot = $ARGV[1];
    shift @ARGV;
    if ($firstdev eq "") {
      $firstdev = "disk"
    }
  } elsif ($ARGV[0] eq "-partition") {
    $partition = $ARGV[1];
    shift @ARGV;
  } elsif ($ARGV[0] eq "-cow") {
    $cowfile = $ARGV[1];
    shift @ARGV;
  } elsif ($ARGV[0] eq "-t") {
      $ENV{'TARGET_VIRT_ENET_TYPE'} = "tuntap";
  } elsif ($ARGV[0] eq "-d") {
    $debug = 1;
### Actions ###
  } elsif ($ARGV[0] eq "status") {
    $dostatus = 1;
  } elsif ($ARGV[0] eq "start") {
    $dostart = 1;
  } elsif ($ARGV[0] eq "start-vmp") {
    $dostartvmp = 1;
  } elsif ($ARGV[0] eq "stop") {
    $dostop = 1;
  } elsif ($ARGV[0] eq "net-start") {
    $donetstart = 1;
  } elsif ($ARGV[0] eq "net-stop") {
    $donetstop = 1;
  } elsif ($ARGV[0] eq "nfs-start") {
    $donfsstart = 1;
  } elsif ($ARGV[0] eq "nfs-stop") {
    $donfsstop = 1;
  } elsif ($ARGV[0] eq "allstop") {
    $doallstop = 1;
  } elsif ($ARGV[0] eq "config") {
    $doconfig = 1;
### instance number and increment controls ###
  } elsif ($ARGV[0] eq "-i") {
    die "ERROR: -i requires an argument" if $ARGV[1] eq "";
    $doinc = $ARGV[1];
    shift @ARGV;
  } elsif ($ARGV[0] eq "-in") {
    die "ERROR: -in requires an argument" if $ARGV[1] eq "";
    $instance = $ARGV[1];
    shift @ARGV;
### Help ###
  } elsif ($ARGV[0] eq "-h" || $ARGV[0] eq "-?") {
    do_usage();
  } else {
    print "ERROR Argument Invalid: $ARGV[0]\n";
    do_usage();
  }
  shift @ARGV;
}

# Print a reasonable error message if QEMU is not present
if (!(-x "$BPATH/qemu")) {
  my $layers = "$progroot/layers";
  if (-f "$progroot/layer_paths") {
    $layers = "$progroot/layer_paths"
  }
  open(LAYERS, "<$layers") ||
      die "ERROR: QEMU is unavailable!\n";

  my $found_qemu = "no";
  my $missing_layer = "no";
  while (<LAYERS>) {
    chomp;
    s/\s*#.*//; # Delete comments
    next if (/^$/ ); # Skip blank lines
    if (!(-d $_)) {
      $missing_layer = "yes";
    } elsif (-f "$_/tools/qemu/Makefile") {
      $found_qemu = "yes";
      last;
    }
  }
  close(LAYERS);

  if ("$found_qemu" eq "no") {
    if ("$missing_layer" eq "no") { # All layers exist, but no QEMU.
      print "\nERROR: QEMU has not been found. This may be due to the\n";
      print "       Wind River Linux tools add-on not being installed\n";
      print "       on your system. Please contact Wind River Support\n";
      print "       if you find this error in question.\n\n";
    } else { # Not all of the layers are present.
      print "ERROR: QEMU is unavailable!\n";
    }
  } else { # Found QEMU, but hasn't been built.
      print "ERROR: QEMU is unavailable!\n";
      print "       Please make sure that QEMU has been built.\n"
   }
  exit 1;
}

## For any exported programs pass the $TARGET_VIRT_INSTANCE
$ENV{'TARGET_VIRT_INSTANCE'} = $doinc;

###### status files ######
my $vardir = "$progroot/host-cross/var";
if ($ENV{'BUILD_VAR_DIR'}) {
  $vardir = $ENV{'BUILD_VAR_DIR'};
}
my $apPid = "$vardir/agent-proxy$instance.pid";
my $vdeDir = "$vardir/vdeSock$instance";
my $vdeDirOrig = $vdeDir;
my $tgtname;
our $qPid;
if ($virt_type eq "qemu") {
  $qPid = "$vardir/qemu$instance.pid";
  $tgtname = "qemu$instance";
} elsif ($virt_type eq "simics") {
  $qPid = "$vardir/simics$instance.pid";
  $tgtname = "simics$instance";
} elsif ($virt_type eq "uml") {
  $qPid = "$vardir/uml$instance.pid";
  $tgtname = "uml$instance";
} else {
    print "ERROR: virt_type is invalid\n";
    exit 1;
}
our $tuntapScript = "$vardir/tuntapScript$instance";
#############################################

### Main Program ###
read_config();

# vde pids have a special case where we use a shared dir
my $swPid;
my $svPid;
if ($tgt_vars{'TARGET_VDE_DIR'} ne "") {
  $swPid = "$vdeDir-sw.pid";
  $svPid = "$vdeDir-sv.pid";
} else {
  ## Append in the doinc for non-shared vde dir
  $swPid = "$vdeDir-sw$instance.pid";
  $svPid = "$vdeDir-sv$instance.pid";
}

if ($ENV{'NFS_EXPORT_DIR'} eq "") {
  $ENV{'NFS_EXPORT_DIR'} = $progroot;
  $tgt_vars{'NFS_EXPORT_DIR'} = $progroot;
}

## Process overrides ##

## su -c instead of sudo
if ($useSU) {
  $tgt_vars{'TARGET_TAP_ROOTACCESS'} = "su -c";
}

## Disk Image and partition number
if ($diskboot ne "") {
  $diskboot = "$progroot/$diskboot" if ($diskboot !~ /^\//);
  $tgt_vars{'TARGET_VIRT_DISK'} = "$diskboot";
}
if ($partition ne "") {
  $tgt_vars{'TARGET_VIRT_DISK_UNIT'} = "$partition";
}

## COW image
if ($cowfile) {
  $cowfile = "$progroot/$cowfile" if ($cowfile !~ /^\//);
  if ($virt_type eq "uml") {
    $tgt_vars{'TARGET_UML_COW'} = "$cowfile";
  }
}

## CDROM Image
if ($isoboot ne "") {
  $isoboot = "$progroot/$isoboot" if ($isoboot !~ /^\//);
  if ($virt_type eq "qemu" || $virt_type eq "simics") {
    $tgt_vars{'TARGET_VIRT_CDROM'} = "$isoboot";

    ## Special case: -cd without -root implies the
    ## -no-kernel option; i.e. boot from the cd image.
    ##  -cd       : boot from cd
    ##  -cd -disk : boot from cd, attach disk
    ##  -disk -cd : Nope, requires -no-kernel to boot from disk
    if ($root eq "" && $firstdev eq "cdrom") {
      $nokernel = 1;
    }
  }
}

if ($nokernel) {
  $tgt_vars{'TARGET_QEMU_KERNEL'} = "";
  $tgt_vars{'TARGET_SIMICS_KERNEL'} = "";
}

if ($tgt_vars{'TARGET_QEMU_KERNEL'} eq "" && $tgt_vars{'TARGET_SIMICS_KERNEL'} eq "") {
  # The -root and -no-kernel options are mutually exclusive.
  if ($root ne "") {
    print "-no-kernel option (or TARGET_QEMU_KERNEL=\"\")\n";
    print "  cannot be used with -root option\n";
    exit 1;
  }

  # If we aren't loading a kernel, we need a disk or cd image.
  if ($firstdev eq "") {
    $firstdev = $tgt_vars{'TARGET_VIRT_BOOT_TYPE'};
  }

  $tgt_vars{'TARGET_VIRT_BOOT_TYPE'} = $firstdev;
  if ($firstdev eq "cdrom") {
    $tgt_vars{'TARGET_QEMU_BOOT_DEVICE'} = "d";
  }

} elsif ($root ne "") {
  ## Verify root file system
  if ($root eq "disk") {
    if ($diskboot eq "") {
      printf "-root disk requires -disk option.\n";
      exit 1;
    }
  } elsif ($root eq "cdrom") {
    if ($isoboot eq "") {
      printf "-root cdrom requires -cd option.\n";
      exit 1;
    }
    $tgt_vars{"TARGET_VIRT_ROOT_MOUNT"} = "ro";
  } elsif ($root ne "usernfs") {
    print "Bad -root argument \"$root\"\n";
    print "Must be one of: usernfs disk cdrom\n";
    exit 1;
  }
  # When we are loading a kernel, this isn't really the boot
  # type, it's the device to mount as the root filesystem.
  $tgt_vars{"TARGET_VIRT_BOOT_TYPE"} = $root;
}

env_export();

if ($doinc > 0) {
  inc_ports($doinc);
}

if ($dostatus) {
  do_status();
}

if ($doOutputStart && $dostart) {
  if ($virt_type eq "qemu") {
    qemu_start();
  } elsif ($virt_type eq "simics") {
    simics_start();
  } elsif ($virt_type eq "uml") {
    uml_start();
  } else {
    print "$virt_type is invalid\n";
    exit 1;
  }
  exit 0;
}

if ($doconfig) {
  do_config();
}

if ($donetstop) {
  vde_stop();
  tuntap_stop();
}

if ($donfsstop) {
  do_nfs_stop();
}

if ($dostop) {
  print "Stopping Target and NFS services\n";
  do_stop();
}

if ($doallstop) {
  print "Stopping Target and All services\n";
  do_stop();
  if ($vdeDir ne $vdeDirOrig) {
    vde_stop();
  }
  kill_stop($apPid,"agent-proxy");
}

if ($donetstart) {
  vde_start();
  tuntap_start();
}

if ($donfsstart) {
  do_nfs_start();
}

if ($dostart) {
  do_start();
}

if ($dostartvmp) {
  do_startvmp();
}

exit 0;

#### Sub routines ####
#############################################
sub chown_file_cleanup {
  my ($file) = @_;
  my @st = stat("$CROSSPATH");
  chown($st[4], -1, $file);
}

sub env_export {
  my $i;
  for ($i = 0; $i < @tgt_confs; $i++) {
    $ENV{$tgt_confs[$i][0]} = $tgt_vars{$tgt_confs[$i][0]};
  }
}

sub inc_ports {
  my $inc = @_[0];
  # Optional argument to check a single conf line
  my $single_conf = @_[1];
  my $i;
  my $up;

  for ($i = 0; $i < @tgt_confs; $i++) {
    if ($single_conf ne "" && $single_conf ne $tgt_confs[$i][0]) {
      next;
    }
    if ($tgt_confs[$i][0] =~ /_RPORT$/) {
      if ($tgt_confs[$i][0] =~ /STETHOSCOPE/ && $inc > 0 &&
	  $ENV{'ALLOW_SCOPE_REDIR'} eq "") {
	delete $tgt_vars{$tgt_confs[$i][0]};
      }
      if ($tgt_vars{$tgt_confs[$i][0]} =~ /^udp:(.*?):/ ||
	  $tgt_vars{$tgt_confs[$i][0]} =~ /^tcp:(.*?):/) {
	if (int($1 > 0)) {
	  $up = int($1) + $inc;
	  $tgt_vars{$tgt_confs[$i][0]} =~ s/^(.*?:)(.*?):/$1$up:/;
	}
      } elsif ($tgt_vars{$tgt_confs[$i][0]} =~ /^(.*?):/) {
	if (int($1 > 0)) {
	  $up = int($1) + $inc;
	  $tgt_vars{$tgt_confs[$i][0]} =~ s/^(.*?):/$up:/;
	}
      }
    } elsif ($tgt_confs[$i][0] =~ /_PORT$/ ||
	     $tgt_confs[$i][0] =~ /_NFSPROG$/ ||
	     $tgt_confs[$i][0] =~ /_MOUNTPROG$/) {
      if (int($tgt_vars{$tgt_confs[$i][0]}) > 0) {
	$tgt_vars{$tgt_confs[$i][0]} = int($tgt_vars{$tgt_confs[$i][0]}) + $inc;
      }
    }
  }

  return if ($single_conf ne "");
  # Finalize by re-reading everything
  env_export();
}

sub do_nfs_start {
  my $kill_opt = "";
  if (!($ENV{'FAKEROOT_KILL'} eq "0" || $ENV{'FAKEROOT_KILL'} eq "no")) {
    $kill_opt = "FAKEROOT_KILL=1 "
  }
  my $var = system("$kill_opt $progroot/scripts/user-nfs.sh restart");
  if ($var != 0) {
    print "NFS ERROR cannot continue.\n";
    print "   Please stop the existing QEMU process(s). Try running the\n";
    print "   following command:\n";
    print "	   pkill rpc\n";
    print "   and retry your previous command.\n";
    print " Or re-run your last command with TOPTS=\"-in 1\" appended\n";
    print " Some diagnostic messages may be available in \n";
    print "      /var/log/messages\n";
    exit 1;
  }
}

sub do_nfs_stop {
  system("$progroot/scripts/user-nfs.sh stop");
  # Stop faked as well if fakeroot_kill is not set
  if (!($ENV{'FAKEROOT_KILL'} eq "0" || $ENV{'FAKEROOT_KILL'} eq "no")) {
    system("$BPATH/pseudo -P $CROSSPATH -S");
  }
}

sub do_status {
  # Exit with 1 if it is running
  # Exit with 0 if it is not running
  my $pidfile = "";
  if ($virt_type eq "qemu") {
    $pidfile = $qPid;
  } else {
    print "status not support for this target\n";
    exit -1;
  }
  if (-f $pidfile) {
    open(F, $pidfile);
    open(F, $pidfile);
    my $pid = <F>;
    close(F);
    $pid =~ s/[\n\r]//g;
    print "Checking $virt_type pid: $pid\n" if $debug;
    my $var = `ps -fp $pid 2> /dev/null`;
    chop($var);
    print "ps result: $var\n" if $debug;
    my $ex = $?;
    print "EXIT code: $ex\n" if $debug;
    if ($ex == 0 && $var =~ /$virt_type/) {
      print "$pid";
      exit 1;
    }
  }
  print "Instance number $instance is not running\n";
  exit 0;
}

sub do_start {
  ## Restart NFS on each target boot
  print "Starting NFS\n" if $debug;
  if ($tgt_vars{"TARGET_VIRT_BOOT_TYPE"} eq "usernfs") {
    do_nfs_start();
  }
  agent_proxy_start();
  vde_start();
  tuntap_test_start();
  if ($virt_type eq "qemu") {
    qemu_start();
  } elsif ($virt_type eq "simics") {
    simics_start();
  } elsif ($virt_type eq "uml") {
    uml_start();
  }
}

sub do_stop {
  if ($tgt_vars{"TARGET_VIRT_BOOT_TYPE"} eq "usernfs") {
    do_nfs_stop();
  }
  if ($vdeDir eq $vdeDirOrig) {
    # We only stop VDE if vdeDir is the default
    vde_stop();
  }
  if ($virt_type eq "qemu") {
    # stop QEMU
    kill_stop($qPid, $tgt_vars{'TARGET_QEMU_BIN'});
  } elsif ($virt_type eq "simics") {
    # stop simics
    kill_stop($qPid, "simics");
  } elsif ($virt_type eq "uml") {
    # stop UML
    kill_stop($qPid, $tgt_vars{'TARGET_UML_KERNEL'},15);
  }
}

sub computeTap {
  # Set dfeault gw and netmask
  my $gw = $tgt_vars{"TARGET_VIRT_GATEWAY"};
  my $netmask = $tgt_vars{"TARGET_VIRT_NETMASK"};

  my $tgtip;
  # The target IP address
  if (($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "tuntap") &&
      ($tgt_vars{'TARGET_VIRT_IP'} eq "auto")) {
    my $inc = 200 + $instance;
    $tgtip = "192.168.$inc.15";
    $gw = "192.168.$inc.1";
    $netmask = "255.255.255.0";
  } elsif ($tgt_vars{'TARGET_VIRT_IP'} eq "auto") {
    $tgtip = "10.0.2." . (100 + $instance);
  } else {
    $tgtip = $tgt_vars{'TARGET_VIRT_IP'} if ($tgt_vars{'TARGET_VIRT_IP'} ne "");
  }
  # The tap device
  my $tapdev = $tgt_vars{'TARGET_TAP_DEV'};
  if ($tapdev eq "auto") {
    $tapdev = "tap$instance";
  }

  # Increment the MAC address by $instance
  my $mac = $tgt_vars{'TARGET_VIRT_MAC'};
  if ($instance > 0) {
    my @smac = split(/:/,$mac);
    my ($i,$n);
    for ($i = 0; $i < 6; $i++) {
      $n = $n * 256;
      $n +=  hex($smac[$i]);
    }
    $n = $n + $instance;
    my $str = "";
    for ($i = 0; $i < 6; $i++) {
      $str = ":" . sprintf("%x",$n % 256) . $str;
      $n -= $n  % 256;
      $n = $n / 256;
    }
    $mac = $str;
    $mac =~ s/^://;
  }
  return ($tgtip,$tapdev,$gw,$netmask,$mac);
}

# launch the tuntap_start if the tap interface does not already exist
sub tuntap_test_start {
  if (!($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "tuntap")) {
    return;
  }
  my ($tgtip,$tapdev,$gw,$netmask) = computeTap();
  my $res = system("/sbin/ifconfig $tapdev > /dev/null 2>/dev/null");
  if ($res != 0) {
    my $cmd = "perl $0 net-start -in $instance";
    if ($tgt_vars{'TARGET_VIRT_EXT_WINDOW'} eq "yes") {
      external_console($cmd, 1)
    } else {
      system($cmd);
    }
  }
}

sub tuntap_start {
  if (!($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "tuntap")) {
    return;
  }
  set_arp();
  my ($tgtip,$tapdev,$gw,$netmask) = computeTap();
  # The tunctl command
  my $tuncmd = "$BPATH/tunctl";
  if ($tgt_vars{'TARGET_TAP_UID'} eq "default") {
    if ($< == 0) {
      my @st = stat("$CROSSPATH");
      $tuncmd .= " -u $st[4]";
    } else {
      $tuncmd .= " -u $<";
    }
  } else {
    $tuncmd .= " -u $tgt_vars{'TARGET_TAP_UID'}";
  }
  $tuncmd .= " -t $tapdev";
  my $hosttap = $tgt_vars{'TARGET_TAP_IP'};
  if ($hosttap eq "auto") {
    $hosttap = $gw;
  }
  ## Construct the Tun TAP script
  open(F,">$tuntapScript") || die "Could not write: $tuntapScript";
  print F<<EOF;
#!/bin/sh
$tuncmd
/sbin/ifconfig $tapdev $hosttap up
echo 1 > /proc/sys/net/ipv4/ip_forward
/sbin/route add -host $tgtip dev $tapdev
echo 1 > /proc/sys/net/ipv4/conf/$tapdev/proxy_arp
$arp -Ds $tgtip $tgt_vars{'TARGET_TAP_HOST_DEV'} pub
for e in 1 2 3 4 5 6 7 8 9 10; do
  if [ ! -e /dev/net/tun ] ; then
    sleep 1
    echo Sleeping \$e for /dev/net/tun
  else
    chmod 666 /dev/net/tun
  fi
done
EOF
  close(F);
  chown_file_cleanup($tuntapScript);
  print "NOTE: The following script must be run as root.\n";
  print "You can use \"sudo\" or \"su -c\" if you change \n";
  print "the preference using teh UI or command line.\n";
  print "    Using root access with: $tgt_vars{'TARGET_TAP_ROOTACCESS'}\n\n";
  print "=====The Script to run as root=====\n";
  system("chmod 755 $tuntapScript");
  system("cat $tuntapScript");
  print "===================================\n";
  return if ($doOutputStart);
  # Check if we have root level access right now...
  if ($< == 0) {
    system("$tuntapScript")
  } else {
    my $cmd = "$tgt_vars{'TARGET_TAP_ROOTACCESS'} $tuntapScript";
    print "Exec: $cmd\n";
    system($cmd);
  }
}

sub set_arp {
  if (-f "/sbin/arp") {
    $arp = "/sbin/arp";
  } elsif (-f "/usr/sbin/arp") {
    $arp = "/usr/sbin/arp";
  } elsif (-f "/bin/arp") {
    $arp = "/bin/arp";
  } elsif (-f "/etc/arp") {
    $arp = "/etc/arp";
  }
}

sub tuntap_stop {
  if (!($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "tuntap")) {
    return;
  }
  set_arp();
  my ($tgtip,$tapdev) = computeTap();
  open(F,">$tuntapScript") || die "Could not write: $tuntapScript";
  print F<<EOF;
#!/bin/sh
$arp -i $tgt_vars{'TARGET_TAP_HOST_DEV'} -d $tgtip pub
$BPATH/tunctl -d $tapdev
EOF
  close(F);
  chown_file_cleanup($tuntapScript);
  print "=====The Script to run as root=====\n";
  system("chmod 755 $tuntapScript");
  system("cat $tuntapScript");
  print "===================================\n";
  return if ($doOutputStart);
  # Check if we have root level access right now...
  if ($< == 0) {
    system("$tuntapScript")
  } else {
    my $cmd = "$tgt_vars{'TARGET_TAP_ROOTACCESS'} $tuntapScript";
    print "Exec: $cmd\n";
    system($cmd);
  }
}

sub vde_start {
  my $cmdsw = "$BPATH/vde_switch";
  my $cmdsv = "$BPATH/slirpvde";

  if (!($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "slirpvde")) {
    return;
  }
  # Start the VDE Switch
  $cmdsw .= " -V -d -s $vdeDir -p $swPid";
  print "$cmdsw\n" if ($doOutputStart);
  if (check_pid_start($swPid,"vde_switch") && !$doOutputStart) {
    print "Starting vde_switch:\n  $cmdsw\n";
    my $res = system("$cmdsw");
    if ($res != 0) {
      print "ERROR vde_switch could not start\n";
      print "   Is it already running or something\n";
      print "   using its port?\n";
      print "   Perhaps try:\n";
      print "     killall vde_switch\n";
      exit -1;
    }
  }
  # Start the slirpvde client
  if ($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "slirpvde" &&
      $tgt_vars{'TARGET_VDE_SLIRP_OPTS'} eq "") {
    # Setup all the tcp and udp redirections
    my $i;
    for ($i = 0; $i < @tgt_confs; $i++) {
      if ($tgt_confs[$i][0] =~ /RPORT$/) {
        if ($tgt_vars{$tgt_confs[$i][0]} ne "0" &&
	    $tgt_vars{$tgt_confs[$i][0]} ne "") {
	  my $redir = $tgt_vars{$tgt_confs[$i][0]};
	  $redir =~ s/^tcp://;
	  $redir =~ s/::/:10.0.2.15:/;
	  $cmdsv .= " -L $redir";
	}
      }
    }
  }
  if ($tgt_vars{'TARGET_VDE_SLIRP_OPTS'} ne "") {
    $cmdsv .= " $tgt_vars{'TARGET_VDE_SLIRP_OPTS'}";
  }

  # Normal cmd line args
  $cmdsv .= " -V -d -dhcp -s $vdeDir -p $svPid";
  $cmdsv .= " $tgt_vars{'TARGET_VDE_ESLIRP_OPTS'}";
  print "$cmdsv\n" if ($doOutputStart);
  if (check_pid_start($svPid,"slirpvde") && !$doOutputStart) {
    print "Starting slirpvde:\n  $cmdsv\n";
    my $res = system("$cmdsv");
    if ($res != 0) {
      print "ERROR slirpvde could not start\n";
      print "   Is it already running or something\n";
      print "   using its port?\n";
      print "   Perhaps try:\n";
      print "     killall slirpvde\n";
      exit -1;
    }
  }
}

sub vde_stop {
  kill_stop($svPid,"slirpvde");
  kill_stop($swPid,"vde_switch");
}


sub external_console {
  my ($cmd,$nofork) = @_;
  my $cpid;
  if ($nofork == 1) {
    $cpid = 0;
  } else {
    $cpid = fork();
  }
  if ($cpid == 0) {
    my $use_sh = 0;
    if ($tgt_vars{'TARGET_VIRT_EXT_CON_CMD'} ne "") {
      if ($tgt_vars{'TARGET_VIRT_EXT_CON_CMD'} =~ /^xterm/) {
	# check for xterm and fall back to gnome-terminal if xterm is
	# not available
	if (system("which xterm") != 0) {
	  $use_sh = 1;
	  $tgt_vars{'TARGET_VIRT_EXT_CON_CMD'} = "gnome-terminal -e"
	}
      }
      if ($tgt_vars{'TARGET_VIRT_CONSOLE_SLEEP'} ne "") {
	$cmd .= "; echo emulation ended ; set -x ; sleep $tgt_vars{'TARGET_VIRT_CONSOLE_SLEEP'}";
      }
      $cmd =~ s/\"/\\\"/g;
      my $precmd = $tgt_vars{'TARGET_VIRT_EXT_CON_CMD'};
      $precmd =~ s/Virtual-WRLinux/Virtual-WRLinux$instance/;
      if ($use_sh) {
	$cmd = "$precmd 'sh -c \"$cmd\"'";
      } else {
	$cmd = "$precmd \"$cmd\"";
      }
      print "FINAL CMD: $cmd\n" if $debug;
      if ($nofork) {
	return system($cmd);
      } else {
	exec $cmd;
      }
    }
  }
  exit 0;
}

sub uml_start {
  my $umlRunTime;
  my $kopts;
  my $qopts;
  # Find kernel
  if ($tgt_vars{"TARGET_UML_KERNEL"} ne "") {
    my $findfile;
    if (-f "$tgt_vars{'TARGET_UML_KERNEL'}") {
      $findfile = "$tgt_vars{'TARGET_UML_KERNEL'}";
    } else {
      $findfile = "$progroot/export/$tgt_vars{'TARGET_BOARD'}-$tgt_vars{'TARGET_UML_KERNEL'}-WR$tgt_vars{'PACKAGE_VERSION'}$tgt_vars{'PACKAGE_EXTRAVERSION'}";
      if ($tgt_vars{'TARGET_KERNEL'} ne "") {
	$findfile .= "_$tgt_vars{'TARGET_KERNEL'}";
      }
    }
    if (-f $findfile) {
      $umlRunTime = $findfile;
    } else {
      print "-----------------------------------------\n";
      print "ERROR: Could not locate kernel: $findfile\n";
      print "target startup failed\n";
      exit -1;
    }
  }

  my ($tgtip,$tapdev,$gw,$netmask,$mac) = computeTap();
  # Setup Ethernet
  if ($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "slirpvde") {
    $qopts .= " eth0=daemon,$mac,unix,$vdeDir/ctl";
  } elsif ($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "tuntap") {
    $qopts .= " eth0=tuntap,$tapdev";
  }

  $kopts .= computeIP($tgt_vars{"TARGET_VIRT_IP"});

  # Console setup
  if ($tgt_vars{"TARGET_QEMU_BOOT_CONSOLE"} ne "") {
    $kopts .= " console=$tgt_vars{'TARGET_QEMU_BOOT_CONSOLE'}";
  }

  # Get NFS Start options
  $kopts .= getUserNFS();
  if ($tgt_vars{'TARGET_VIRT_BOOT_TYPE'} eq "disk") {
    $kopts .= " ubd0=";
    if ($tgt_vars{'TARGET_UML_COW'} ne "") {
      $kopts .= "$tgt_vars{'TARGET_UML_COW'},"
    }
    $kopts .= $tgt_vars{'TARGET_VIRT_DISK'};
  }

  # Memory options
  if ($tgt_vars{'TARGET_UML_MEM'} ne "" && $tgt_vars{'TARGET_UML_MEM'} ne "default") {
    $kopts .= " mem=$tgt_vars{'TARGET_UML_MEM'}M";
  }

  # additional binary options
  if ($tgt_vars{"TARGET_UML_OPTS"} ne "") {
    $qopts .= " $tgt_vars{'TARGET_UML_OPTS'}";
  }

  # additional kernel options
  if ($tgt_vars{"TARGET_UML_KERNEL_OPTS"} ne "") {
    $kopts .= " $tgt_vars{'TARGET_UML_KERNEL_OPTS'}";
  }

  # Usermode agent
  if ($tgt_vars{"TARGET_VIRT_UMA_START"} eq "yes") {
    $kopts .= " UMA=1";
  }

  ## Start up the UML Engine
  my $cmd = "$umlRunTime $qopts $kopts";
  if ($doOutputStart) {
    print "$cmd\n";
    return;
  }

  print "Running UML:\n$cmd\n";
  if ($tgt_vars{'TARGET_VIRT_EXT_WINDOW'} eq "yes") {
    external_console("echo \\\$\\\$ > $qPid ; exec $cmd");
  } else {
    open(F,">$qPid");
    print F "$$\n";
    close(F);
    chown_file_cleanup($qPid);
    exec $cmd;
  }
}

sub compute_cpu_mask {
  if ($tgt_vars{'TARGET_VIRT_CPU_MASK'} ne "" &&
      $tgt_vars{'TARGET_VIRT_CPU_MASK'} ne "none" &&
      $tgt_vars{'TARGET_VIRT_CPU_MASK'} ne "auto") {
    return $tgt_vars{'TARGET_VIRT_CPU_MASK'};
  }
  my $local_cpu_mask = `taskset -p \$\$ 2>/dev/null`;
  chop($local_cpu_mask);
  $local_cpu_mask =~ s/.*mask: //;
  $local_cpu_mask = hex($local_cpu_mask);
  if ($? ne "0") {
    $use_taskset = 0;
    return 0x1;
  }
  # Figure out how many cpus are available
  my $cpunum = 0;
  my $j = 0;
  my @cpu;
  my $target_cpus = $tgt_vars{'TARGET_QEMU_SMP'};
  my $local_instance = $instance - 1;
  $target_cpus = 1 if $target_cpus == 0;
  my $cpu_mask = 0;
  while ($target_cpus--) {
    $local_instance++;
    while ($local_cpu_mask) {
      if ($local_cpu_mask & 0x1) {
	push(@cpu, $j);
	$cpunum++;
      }
      $local_cpu_mask = $local_cpu_mask >> 1;
      $j++;
    }
    $cpu_mask |= 1 << $cpu[$local_instance % $cpunum];
  }
  return $cpu_mask;
}

sub qemu_start {
  my $qopts;
  my $kopts;
  ## Construct the QEMU options
  # Graphics suppport
  if ($tgt_vars{"TARGET_QEMU_GRAPHICS"} ne "yes") {
    $qopts .= " -nographic";
  }
  # Keyboard type
  if ($tgt_vars{"TARGET_QEMU_KEYBOARD"} ne "") {
    $qopts .= " -k $tgt_vars{'TARGET_QEMU_KEYBOARD'}";
  }
  # Find kernel
  if ($tgt_vars{"TARGET_QEMU_KERNEL"} ne "") {
    if (-f "$tgt_vars{'TARGET_QEMU_KERNEL'}") {
      $qopts .= " -kernel $tgt_vars{'TARGET_QEMU_KERNEL'}";
    } else {
      my $findfile = "$progroot/export/$tgt_vars{'TARGET_BOARD'}-$tgt_vars{'TARGET_QEMU_KERNEL'}-WR$tgt_vars{'PACKAGE_VERSION'}$tgt_vars{'PACKAGE_EXTRAVERSION'}";
      if (!(-f $findfile)) {
	# try without the -WR
	my $ff = "$progroot/bitbake_build/tmp/deploy/images/$tgt_vars{'TARGET_QEMU_KERNEL'}-$tgt_vars{'TARGET_BOARD'}.bin";
	if ($findfile) {
	  $findfile = $ff;
	}
      }
      if ($tgt_vars{'TARGET_KERNEL'} ne "") {
	my $ff = $findfile;
	$ff .= "_$tgt_vars{'TARGET_KERNEL'}";
	$findfile = $ff if (-e $ff);
      }
      if (-f $findfile) {
	$qopts .= " -kernel $findfile";
      } else {
	print "-----------------------------------------\n";
	print "ERROR: Could not locate kernel: $findfile\n";
	print "target startup failed\n";
	exit -1;
      }
    }
  }
  my ($tgtip,$tapdev,$gw,$netmask,$mac) = computeTap();
  # Setup all the tcp and udp redirections
  if ($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "slirp") {
    my $i;
    for ($i = 0; $i < @tgt_confs; $i++) {
      if ($tgt_confs[$i][0] =~ /RPORT$/) {
	if ($tgt_vars{$tgt_confs[$i][0]} ne "0" &&
	    $tgt_vars{$tgt_confs[$i][0]} ne "") {
	  $qopts .= " -redir $tgt_vars{$tgt_confs[$i][0]}";
	}
      }
    }
    my $ex_user = ",hostname=\"$tgtname\"" if $tgtname ne "";
    $qopts .= " -net user$ex_user -net nic,macaddr=$mac";
    $qopts .= ",model=$tgt_vars{'TARGET_QEMU_ENET_MODEL'}" if $tgt_vars{'TARGET_QEMU_ENET_MODEL'} ne "auto" &&
	$tgt_vars{'TARGET_QEMU_ENET_MODEL'} ne "";
  } elsif ($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "slirpvde") {
    $qopts .= " -net nic,macaddr=$mac";
    $qopts .= ",model=$tgt_vars{'TARGET_QEMU_ENET_MODEL'}" if $tgt_vars{'TARGET_QEMU_ENET_MODEL'} ne "auto" &&
	$tgt_vars{'TARGET_QEMU_ENET_MODEL'} ne "";
    $qopts .= " -net vde,sock=$vdeDir";
  } elsif ($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "tuntap") {
    $qopts .= " -net tap,ifname=$tapdev,script=/bin/true -net nic,macaddr=$mac";
    $qopts .= ",model=$tgt_vars{'TARGET_QEMU_ENET_MODEL'}" if $tgt_vars{'TARGET_QEMU_ENET_MODEL'} ne "auto" &&
	$tgt_vars{'TARGET_QEMU_ENET_MODEL'} ne "";
  } elsif ($tgt_vars{'TARGET_QEMU_ENET_MODEL'} ne "auto" && $tgt_vars{'TARGET_QEMU_ENET_MODEL'} ne "") {
    $qopts .= " -net nic,model=$tgt_vars{'TARGET_QEMU_ENET_MODEL'}";
  }
  # Hard Disk
  if ($tgt_vars{'TARGET_VIRT_DISK'} ne "") {
    $qopts .= " -hda $tgt_vars{'TARGET_VIRT_DISK'}";
  }

  # Alternate cpu
  if ($tgt_vars{'TARGET_QEMU_CPU'} ne "") {
    $qopts .= " -cpu $tgt_vars{'TARGET_QEMU_CPU'}";
  }


  # CDROM
  if ($tgt_vars{'TARGET_VIRT_CDROM'} ne "") {
    $qopts .= " -cdrom $tgt_vars{'TARGET_VIRT_CDROM'}";
  }

  # Boot device
  if ($tgt_vars{'TARGET_QEMU_BOOT_DEVICE'} ne "") {
    $qopts .= " -boot $tgt_vars{'TARGET_QEMU_BOOT_DEVICE'}";
  }

  # Setup serial redirection
  if ($tgt_vars{'TARGET_QEMU_PROXY_PORT'} ne "" &&
      $tgt_vars{'TARGET_QEMU_PROXY_PORT'} ne "0" &&
      $tgt_vars{'TARGET_QEMU_USE_STDIO'} ne "yes") {
    $qopts .= " -serial mon:tcp:localhost:$tgt_vars{'TARGET_QEMU_PROXY_LISTEN_PORT'} -monitor null";
  }

  # Memory options
  if ($tgt_vars{'TARGET_QEMU_MEM'} ne "" && $tgt_vars{'TARGET_QEMU_MEM'} ne "default") {
    $qopts .= " -m $tgt_vars{'TARGET_QEMU_MEM'}";
  }

  if ($tgt_vars{"TARGET_QEMU_OPTS"} ne "") {
    $qopts .= " $tgt_vars{'TARGET_QEMU_OPTS'}";
  }

  ## Construct the kernel boot line
  if ($tgt_vars{"TARGET_QEMU_BOOT_CONSOLE"} ne "") {
    $kopts .= " console=$tgt_vars{'TARGET_QEMU_BOOT_CONSOLE'}";
  }

  $kopts .= computeIP($tgt_vars{"TARGET_VIRT_IP"});
  if ($kopts =~ /ip=dhcp/ || $tgtip eq "none") {
    $tgtip = "10.0.2.15";
  }

  # Get NFS Start options
  $kopts .= getUserNFS();

  if ($tgt_vars{'TARGET_VIRT_BOOT_TYPE'} eq "disk") {
    $kopts .= " root=/dev/hda$tgt_vars{'TARGET_VIRT_DISK_UNIT'}";
    $kopts .= " $tgt_vars{'TARGET_VIRT_ROOT_MOUNT'}";
  } elsif ($tgt_vars{'TARGET_VIRT_BOOT_TYPE'} eq "cdrom") {
    $kopts .= " root=/dev/hdc$tgt_vars{'TARGET_VIRT_DISK_UNIT'}";
    $kopts .= " $tgt_vars{'TARGET_VIRT_ROOT_MOUNT'}";
  }

  if ($tgt_vars{"TARGET_QEMU_KERNEL_OPTS"} ne "") {
    $kopts .= " $tgt_vars{'TARGET_QEMU_KERNEL_OPTS'}";
  }

  # Usermode agent
  if ($tgt_vars{"TARGET_VIRT_UMA_START"} eq "yes") {
    $kopts .= " UMA=1";
  }

  # Chop off leading spaces
  $qopts =~ s/^ //;
  $kopts =~ s/^ //;

  if ($kopts ne "" && $tgt_vars{"TARGET_QEMU_KERNEL"} ne "") {
    $kopts = "-append \"$kopts\"";
  } else {
    # If we're not loading a kernel, we don't need kernel opts
    $kopts = "";
  }
  kill_stop($qPid, "qemu") if (!$doOutputStart);
  ## Run QEMU
  my $qbin = $tgt_vars{'TARGET_QEMU_BIN'};
  if (! -f $qbin) {
    $qbin = "$BPATH/$tgt_vars{'TARGET_QEMU_BIN'}";
  }
  if (! -f $qbin) {
    $qbin = `which $tgt_vars{'TARGET_QEMU_BIN'} 2> /dev/null`;
    chop($qbin);
  }
  if (! -f $qbin) {
    print "ERROR Could not locate a qemu binary: $tgt_vars{'TARGET_QEMU_BIN'}\n";
    exit -1;
  }
  # Invoke qemu to see what version of qemu/kvm we are running
  my $qbin_uses_dash_s = 1;
  open(IN, "$qbin -h|");
  while (<IN>) {
    chop();
    if ($_ =~ /^-s.*-gdb tcp/) {
      $qbin_uses_dash_s = 0;
    }
  }
  # debug port
  if ($tgt_vars{'TARGET_QEMU_DEBUG_PORT'} ne "0") {
    if ($qbin_uses_dash_s) {
      $qopts .= " -s -p $tgt_vars{'TARGET_QEMU_DEBUG_PORT'}";
    } else {
      $qopts .=" -gdb tcp::$tgt_vars{'TARGET_QEMU_DEBUG_PORT'}";
    }
  }
  # SMP options
  if ($tgt_vars{'TARGET_QEMU_SMP'} ne "0" && $tgt_vars{'TARGET_QEMU_SMP'} ne "") {
    $qopts .= " -smp $tgt_vars{'TARGET_QEMU_SMP'}";
  }
  # debug wait
  if ($tgt_vars{'TARGET_VIRT_DEBUG_WAIT'} ne "no") {
    $qopts .= " -S";
  }

  my $cmd = "$qbin $qopts $kopts -pidfile $qPid";
  if ($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "slirpvde") {
    $cmd = "$BPATH/vdeq $cmd"
  }
  if ($tgt_vars{'TARGET_VIRT_CPU_MASK'} ne "" &&
      $tgt_vars{'TARGET_VIRT_CPU_MASK'} ne "none") {
    my $cpu_mask = compute_cpu_mask;
    if ($use_taskset) {
      $cmd = sprintf("taskset %x %s", $cpu_mask, $cmd);
    }
  }
  my $findfile = "vmlinux-symbols";
  if (!(-f $findfile) && $findfile ne "") {
    $findfile = "$progroot/export/$main::tgt_vars{'TARGET_BOARD'}-$findfile-WR$main::tgt_vars{'PACKAGE_VERSION'}$main::tgt_vars{'PACKAGE_EXTRAVERSION'}";
    if ($main::tgt_vars{'TARGET_KERNEL'} ne "") {
      $findfile .= "_$main::tgt_vars{'TARGET_KERNEL'}";
    }
    if (!(-f $findfile)) {
      $findfile = "vmlinux";
      $findfile = "$progroot/export/$main::tgt_vars{'TARGET_BOARD'}-$findfile-WR$main::tgt_vars{'PACKAGE_VERSION'}$main::tgt_vars{'PACKAGE_EXTRAVERSION'}";
      if ($main::tgt_vars{'TARGET_KERNEL'} ne "") {
	$findfile .= "_$main::tgt_vars{'TARGET_KERNEL'}";
      }
    }
  }
  if ($doOutputStart) {
    print "# vmlinuxSymbolFile=$findfile\n";
    print "# ipaddr=$tgtip\n";
    print "$cmd\n";
    return;
  }

  # Final sanity checks or error out
  # --------------------------------
  # Check for disk and or kernel
  if ($cmd !~ /\-kernel/ && 
      !($cmd =~ /\-cdrom/ || $tgt_vars{'TARGET_VIRT_DISK'} ne "" ||
       $tgt_vars{'TARGET_VIRT_BOOT_TYPE'} eq "pxe")) {
    print "\nERROR: When not specifing a kernel you must specify either a disk,\n";
    print "       cdrom, or PXE image to boot from.\n";
    exit 1;
  }

  # Start the simulator
  print "Running QEMU:\n$cmd\n";
  if ($tgt_vars{'TARGET_VIRT_EXT_WINDOW'} eq "yes") {
    external_console($cmd);
  } else {
    exec "ostty=`stty -g`; $cmd; v=\$?;stty \$ostty 2>/dev/null;exit \$v";
  }
}

sub computeIP {
  my($ip) = @_;
  my ($tgtip,$tapdev) = computeTap();
  if ($ip eq "none" || $ip eq "") {
    return "";
  }
  my ($tgtip,$tapdev,$gw,$netmask) = computeTap();
  if ($ip eq "auto" &&
      ($tgt_vars{'TARGET_VIRT_ENET_TYPE'} eq "tuntap")) {
    return " ip=$tgtip:$gw:$gw:$netmask:$tgtname:$tgt_vars{'TARGET_TAP_ETH_DEV'}:off";
  } elsif ($ip eq "dhcp" || ($ip eq "auto" && $tgt_vars{'TARGET_VDE_DIR'} eq "")) {
    return " ip=dhcp";
  } else {
    return " ip=$tgtip:$gw:$gw:$netmask:$tgtname:$tgt_vars{'TARGET_TAP_ETH_DEV'}:off";
  }
}

sub getUserNFS {
  if ($tgt_vars{"TARGET_VIRT_BOOT_TYPE"} =~ /^usernfs/) {
    my $ex = $tgt_vars{'NFS_EXPORT_DIR'};
    if ($ex eq "") {
      $ex = $progroot;
    }
    if ($tgt_vars{'NFS_MOUNT_DIR'} ne "") {
      if ($tgt_vars{'NFS_MOUNT_DIR'} !~ /^\//) {
	$ex .= "/";
      }
      $ex .= $tgt_vars{'NFS_MOUNT_DIR'};
    }
    my ($tgtip,$tapdev,$gw,$netmask) = computeTap();
    my $nfs_args = "udp";
    if ($tgt_vars{"TARGET_VIRT_BOOT_TYPE"} eq "usernfstcp") {
      $nfs_args = "tcp,rsize=1024,wsize=1024";
    } elsif ($tgt_vars{"TARGET_VIRT_BOOT_TYPE"} =~ /^usernfs(.+)/) {
      $nfs_args = $1;
    }
    return " root=/dev/nfs nfsroot=$gw:$ex,nfsvers=2,port=$ENV{'NFS_PORT'},mountprog=$tgt_vars{'NFS_MOUNTPROG'},nfsprog=$tgt_vars{'NFS_NFSPROG'},$nfs_args,mountport=$tgt_vars{'MOUNT_PORT'} $tgt_vars{'TARGET_VIRT_ROOT_MOUNT'}";
  }
  return "";
}

sub agent_proxy_start {
  ## Start the agent-proxy
  if ($tgt_vars{"TARGET_QEMU_PROXY_PORT"} ne "" &&
      int($tgt_vars{"TARGET_QEMU_PROXY_PORT"}) > 0 &&
      $tgt_vars{'TARGET_QEMU_USE_STDIO'} ne "yes") {
    my $pid;
    my $cmd = "$BPATH/agent-proxy 0+$tgt_vars{'TARGET_QEMU_PROXY_PORT'} 0.0.0.0 tcplisten:$tgt_vars{'TARGET_QEMU_PROXY_LISTEN_PORT'} -D -f $apPid\n";

    if (!check_pid_start($apPid, "agent-proxy")) {
      return;
    }
    print "Starting console proxy:\n  $cmd\n";
    my $res = system("$cmd");
    if ($res != 0) {
      print "ERROR Agent Proxy could not start\n";
      print "   Is it already running or something\n";
      print "   using its port?\n";
      print "   Perhaps try:\n";
      print "     killall agent-proxy\n";
      exit -1;
    }
  }
}

sub kill_stop {
  my ($pidfile,$prog,$sig) = @_;
  if (-f $pidfile) {
    open(F, $pidfile);
    my $pid = <F>;
    close(F);
    $pid =~ s/[\n\r]//g;
    print "Checking $prog pid: $pid\n" if $debug;
    my $var = `ps -fp $pid 2> /dev/null`;
    chop($var);
    print "ps result: $var\n" if $debug;
    my $ex = $?;
    print "EXIT code: $ex\n" if $debug;
    if ($ex == 0 && $var =~ /$prog/) {
      print "Killing $prog: $pid\n";
      if ($sig ne "") {
	kill($sig,$pid);
      } else {
	kill(1,$pid);
      }
    }
    unlink($pidfile);
  }
}

# Return 0 == daemon need to be started
# Return 1 == daemon does not need to be started
sub check_pid_start {
  my ($pidfile, $prog) = @_;
  if (-f $pidfile) {
    open(F, $pidfile);
    my $pid = <F>;
    print "Checking $prog pid: $pid\n" if $debug;
    my $var = `ps -fp $pid 2> /dev/null`;
    chop($var);
    print "ps result: $var\n" if $debug;
    my $ex = $?;
    print "EXIT code: $ex\n" if $debug;
    if ($ex == 0 && $var =~ /$prog/) {
      return 0;
    }
    print "$prog not running, restarting...\n";
    unlink($pidfile);
  }
  return 1;
}

sub read_config {
  my $extra_brd_config = "$simics_dir/board-configs/$tgt_vars{'TARGET_BOARD'}/config.sh";
  my @var;
  my @var1;
  my @var2;

  if (-e $extra_brd_config) {
    open(VAR, $extra_brd_config);
    @var1 = <VAR>;
    close(VAR);
  }
  open(VAR, "$config_file");
  @var2 = <VAR>;
  close(VAR);
  push(@var, @var1, @var2);

  my $i;
  # Any variable with a number takes precedence over one without a
  # number, IE: TARGET2_QEMU_BIN vs TARGET_QEMU_BIN
  # Use a hash to determine to make sure this is tracked
  #
  # Any environment variable overrides something in the config file
  # EX_TARGET* env vars will append informaiton to existing variables
  my %track_number;
  while ($_ = $var[0] && shift @var) {
    chop();
    if ($_ =~ /^(TARGET_|NFS_)(.*?)=(.*)/) {
      my $a = "$1$2";
      my $b = cleanchars($3);
      if (exists($ENV{$a})) {
	$tgt_vars{$a} = $ENV{$a};
      } else {
	$tgt_vars{$a} = $b;
      }
      print "Read from $config_file: $a == $b\n" if $debug;
    } elsif ($_ =~ /^(TARGET|NFS)($instance\_.*?)=(.*)/) {
      my $var_type = $1;
      my $a = "$1$2";
      my $b = cleanchars($3);
      my $a_orig = $a;
      $a =~ s/^$var_type$instance/$var_type/;
      # Make sure the numbered variables take precedence over the
      # non numbered ones.
      if (exists($ENV{$a_orig})) {
	$track_number{$a_orig} = $ENV{$a_orig};
      } elsif (exists($ENV{$a}))  {
	$track_number{$a_orig} = $ENV{$a};
      } else {
	$track_number{$a_orig} = $b;
      }
    }
  }
  setup_makefile_vars();

  ## Empty out the track_number variable with the correct overrides
  foreach $i (keys %track_number) {
    my $a = $i;
    $a =~ s/^(TARGET|NFS)(\d+)_/$1_/;
    $tgt_vars{$a} = $track_number{$i};
  }
  ## Fill in config
  for ($i = 0; $i < @tgt_confs; $i++) {
    if (!exists($tgt_vars{$tgt_confs[$i][0]})) {
      print "Adding default $tgt_confs[$i][0]=$tgt_confs[$i][2]\n" if $debug;
      my $disp = tgt_confs_instance($i);
      if (exists($ENV{$disp})) {
	$tgt_vars{$tgt_confs[$i][0]} = $ENV{$disp};
      } elsif (exists($ENV{$tgt_confs[$i][0]})) {
	$tgt_vars{$tgt_confs[$i][0]} = $ENV{$tgt_confs[$i][0]};
      } else {
	$tgt_vars{$tgt_confs[$i][0]} = $tgt_confs[$i][2];
	if ($instance > 0) {
	  inc_ports($instance*100,$tgt_confs[$i][0]);
	}
      }
    }
    # Process the append rule
    if (exists($ENV{"EX_$tgt_confs[$i][0]"})) {
      $tgt_vars{$tgt_confs[$i][0]} .= " " . $ENV{"EX_$tgt_confs[$i][0]"};
      print "Processing EX_ for $tgt_confs[$i][0]=$tgt_vars{$tgt_confs[$i][0]}\n" if $debug;
    }
  }
  ## Set environment status variables
  if ($tgt_vars{'TARGET_VDE_DIR'} ne "") {
    $vdeDir = $tgt_vars{'TARGET_VDE_DIR'};
  }
  if ($tgt_vars{'TARGET_UML_HOSTNAME'} ne "") {
    $tgtname = $tgt_vars{'TARGET_UML_HOSTNAME'};
  }
  if ($tgt_vars{'TARGET_QEMU_HOSTNAME'} ne "") {
    $tgtname = $tgt_vars{'TARGET_QEMU_HOSTNAME'};
  }
}

sub do_save {
  my %send = %tgt_vars;
  my $i;
  if (!open(OUT,">$config_file.$$")) {
    print "ERROR could not write $config_file.$$\n";
    sleep(5);
    return;
  }
  open(IN,"$config_file");
  while (<IN>) {
    for ($i = 0; $i < @tgt_confs; $i++) {
      my $disp = tgt_confs_instance($i);
      if ($_ =~ /^$disp=/) {
	if (exists($send{$tgt_confs[$i][0]})) {
	  print OUT "$disp=\"$tgt_vars{$tgt_confs[$i][0]}\"\n";
	  delete($send{$tgt_confs[$i][0]});
	}
	last;
      }
    }
    if ($i >= @tgt_confs) {
      print OUT $_;
    }
  }
  # Print in the rest of the defaults
  for ($i = 0; $i < @tgt_confs; $i++) {
    if (exists($send{$tgt_confs[$i][0]})) {
      my $disp = tgt_confs_instance($i);
      print OUT "$disp=\"$tgt_vars{$tgt_confs[$i][0]}\"\n";
    }
  }
  close(OUT);
  close(IN);
  rename("$config_file.$$","$config_file");

  # Finalize by re-reading everything
  read_config();
  env_export();
}

sub do_change_opt {
  my $opt = @_[0];
  print "\n";
  my $disp = tgt_confs_instance($opt);
  print "    Change Var: \"$disp\"\n";
  print "   Description: $tgt_confs[$opt][1]\n";
  print "Global default: \"$tgt_confs[$opt][2]\"\n";
  print " Current Value: \"$tgt_vars{$tgt_confs[$opt][0]}\"\n";
  print "\n";
  print "Type a new value in and press enter or...\n";
  print "          To set to \"\" enter: +\n";
  print "Use the global default enter: -\n";
  print "   Press enter to do nothing:\n";
  print "\n";
  print "New Value:";
  my $inp = <STDIN>;
  chop($inp);
  if ($inp eq "+") {
    $tgt_vars{$tgt_confs[$opt][0]} = "";
    $ENV{$tgt_confs[$opt][0]} = "";
  } elsif ($inp eq "-") {
    $tgt_vars{$tgt_confs[$opt][0]} = $tgt_confs[$opt][2];
    $ENV{$tgt_confs[$opt][0]} = $tgt_confs[$opt][2];
  } elsif ($inp ne "") {
    $tgt_vars{$tgt_confs[$opt][0]} = $inp;
    $ENV{$tgt_confs[$opt][0]} = $inp;
  }
}

sub print_xml_config {
  print "<$virt_type instance=\"$instance\">\n";
  my $i;
  for ($i = 0; $i < @tgt_confs; $i++) {
    my $disp = tgt_confs_instance($i);
    print "\t<option name=\"$tgt_confs[$i][0]\" value=\"$tgt_vars{$tgt_confs[$i][0]}\">\n";
    ## The field type and validator information
    print "\t\t<info type=\"$tgt_confs[$i][3]\"";
    if ($tgt_confs[$i][5] ne "") {
      print " default=\"$tgt_confs[$i][5]\"";
    }
    print " validator=\"$tgt_confs[$i][4]\"/>\n";
    ## The description
    print "\t\t<description>\n";
    print "\t\t\t$tgt_confs[$i][1]\n";
    print "\t\t</description>\n";
    print "\t</option>\n";
  }
  print "</$virt_type>\n";
}

sub save_xml_config {
  while (<STDIN>) {
    chop();
    if ($_ =~ /.*?\<option +name=\"(.*?)\" value=\"(.*?)\"/) {
      my $n = $1;
      my $v = $2;
      print "GOT: option $n=$v\n" if $debug;
      $tgt_vars{$n} = $v;
    }
  }
  do_save();
}

sub do_config {
  if ($xmlout) {
    print_xml_config();
    exit(0);
  }
  if ($xmlin) {
    save_xml_config();
    exit(0);
  }
  my $i;
  while (1) {
    # Main menu
    print "===QEMU and or User NFS Configuration===\n";
    for ($i = 0; $i < @tgt_confs; $i++) {
      my $disp = tgt_confs_instance($i);
      printf("%2i: $disp=$tgt_vars{$tgt_confs[$i][0]}\n",$i+1);
    }
    #process choices
    print "Enter number to change (q quit)(s save): ";
    my $inp = <STDIN>;
    chop($inp);
    if ($inp eq 'q') {
      return;
    } elsif ($inp eq 's') {
      do_save();
    } elsif (int($inp) > 0 && int($inp) <= @tgt_confs) {
      do_change_opt(int($inp) - 1);
    }
  }
}

sub simTypeAvailable {
  my $i;
  for ($i = 0; $i < @ARGV; $i++) {
    if ($ARGV[$i] eq "-in" && ($i + 1 < @ARGV)) {
      $instance = int($ARGV[$i+1]);
      last;
    }
  }

  my $instcheck = "^TARGET_VIRT" . $instance . "_TYPE=(.*)";
  if ($ENV{'TARGET_VIRT_TYPE'} ne "") {
    $virt_type = $ENV{'TARGET_VIRT_TYPE'};
  }

  my $fallback = "";
  my @var;
  my @var1;
  my @var2;
  my $extra_brd_config = "$simics_dir/board-configs/$tgt_vars{'TARGET_BOARD'}/config.sh";

  if (-e $extra_brd_config) {
    open(VAR, $extra_brd_config) || die "No config file: $extra_brd_config";
    @var1 = <VAR>;
    close(VAR);
  }

  open(VAR, "$config_file") || die "No config file: $config_file";
  @var2 = <VAR>;
  close(VAR);
  push(@var, @var1, @var2);
  while ($_ = $var[0] && shift @var) {
    chop();
    next if ($_ =~ /^\#/);
    if ($_ =~ /$instcheck/) {
      $virt_type = cleanchars($1);
    } elsif ($_ =~ /^TARGET_SIMICS_BIN/) {
      $fallback = "simics" if $fallback eq "";
      $got_simics = 1;
    } elsif ($_ =~ /^TARGET_QEMU_BIN/ && $_ !~ /\"\"/) {
      $fallback = "qemu";
      $got_qemu = 1;
    } elsif ($_ =~ /^TARGET_UML_KERNEL/) {
      $fallback = "uml" if $fallback eq "";
      $got_uml = 1;
    }
  }

  if ($virt_type eq "" && $fallback ne "") {
    $virt_type = $fallback;
  }
}

# Read through the config file
# and look to see if it is a UML, QEMU or Simics BSP
sub bspDetect {

  if (!($virt_type eq "qemu" || $virt_type eq "uml" || $virt_type eq "simics")) {
    print "ERROR: This BSP does not support UML, QEMU or Simics\n";
    exit 1;
  }
  if ($virt_type eq "qemu" && !$got_qemu && $ENV{'TARGET_QEMU_BIN'} eq "") {
    print "ERROR: No qemu binary specified in config.sh\n";
    exit 1;
  }
  if ($virt_type eq "simics" && !$got_simics && $ENV{'TARGET_SIMICS_BIN'} eq "") {
    print "ERROR: No simics binary specified in config.sh\n";
    exit 1;
  }
}

sub cleanchars {
  my $v = @_[0];
  $v =~ s/[ \t]+$//;
  $v =~ s/^\"//;
  $v =~ s/\"$//;
  return $v;
}

# Add the instance number into tgt_confs request
sub tgt_confs_instance {
  my $opt = @_[0];
  my $disp = $tgt_confs[$opt][0];
  $disp =~ s/^TARGET/TARGET$instance/;
  $disp =~ s/^NFS/NFS$instance/;
  return $disp;
}

sub find_simics_dir {
  if (-e "$progroot/scripts/config-target-simics.pl") {
    return "$progroot/scripts";
  }

  my $layers = "$progroot/layers";
  if (-f "$progroot/layer_paths") {
    $layers = "$progroot/layer_paths"
  }
  if (-e "$layers") {
    open(F, "$layers");
    while (<F>) {
      chop();
      if (-e "$_/wrll-simics/config-target-simics.pl") {
	close(F);
	return "$_/wrll-simics";
      }
      if (-e "$_/wr-simics/config-target-simics.pl") {
	close(F);
	return "$_/wr-simics";
      }
    }
    close(F);
  }

  if (-e "$tgt_vars{'TOP_PRODUCT_DIR'}/../layers/wrll-simics/config-target-simics.pl") {
    return "$tgt_vars{'TOP_PRODUCT_DIR'}/../layers/wrll-simics";
  }
  if (-e "$tgt_vars{'TOP_PRODUCT_DIR'}/../layers/wr-simics/config-target-simics.pl") {
    return "$tgt_vars{'TOP_PRODUCT_DIR'}/../layers/wr-simics";
  }
  return "";
}

sub do_usage {
  print "Usage $0 [Options] <command>\n";
  print<<EOF;
  Options:
  -h,-?  Display this help and exit
  -c     Use text console
  -gc    Use graphics console
  -p     Use telnet proxy as console
  -i #   Increment the remote port offsets by #
         typically used when starting more than
         one target
  -d     Extra script debug output
  -w     Wait until debugger attaches to QEMU
  -x     Use an external console defined by
         TARGET_VIRT_EXTERNAL_CONSOLE
         and go into the background
  -o     Output the target start command which you
         could use to start a debugger with
  -m #   Number of megs of RAM to use on the target
  -su    Use "su -c" instead of "sudo" for root access
  -t     Use tuntap
  -cd <iso_file>      Boot from CD (QEMU Only)
  -disk <disk_image>  Boot kernel with disk image
  -partition #        Specify root partition for disk image
  -cow <cow_file>     COW file for (UML Only)
  -no-kernel          Do not load a kernel image (boot from cd or disk)
  -root <device>      Device to use for root fs (usernfs, disk or cdrom)
  -xmlin              Read configuration from stdin in xml format
  -xmlout             Display configuration in xml format

  Environment variables:
  TARGET_CONFIG_FILE    The configuration file (default: config.sh)
  TARGET_TOPTS          If no command line options are specified, these are
                        used instead
  BUILD_VAR_DIR         Variables directory when build (default: host-cross/var/)
  NFS_EXPORT_DIR        nfs export directory (default: TOP_BUILD_DIR)
  ALLOW_SCOPE_REDIR     Allow qemu to redirect the port scope
  FAKEROOT_KILL         Stop nfs before start (yes or no, default: yes)

  Commands:
  status      Display the target status
  start       Start target, NFS server and proxy (if needed)
  stop        Stop the target and NFS server...
  nfs-start   Start the NFS server
  nfs-stop    Stop the NFS server
  net-start   Start the network server (TUN/TAP)
  net-stop    Stop the network server (TUN/TAP)
  allstop     Stop target, NFS server and proxy
  config      Display or change the default configuration

EOF
  exit(0);
}
