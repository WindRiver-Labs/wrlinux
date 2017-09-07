#!/usr/bin/env python
###############################################################################
#
# Copyright (C) 2013 Wind River Systems, Inc.
#
# This code is licensed under the GPLv2.
#
###############################################################################
import sys
import getopt
import subprocess
import imp
import string
import os
import re
import random


# global variables section
vdsmPresent = True
vdsmPath = "/usr/share/vdsm"
cpuinfoFile = "/proc/cpuinfo"
meminfoFile = "/proc/meminfo"
versionFile = "/proc/version"
modulesFile = "/proc/modules"


# check for the existence of vdsm on the current system. if exists, then import
# the required utility classes
if os.path.exists(vdsmPath):
    vdsmPresent = True
    sys.path.append(vdsmPath)
    from vdsm import utils
    import caps
else:
    vdsmPresent = False
  


# this method is used to print a simple centered headline to the console.
# the input parameter is stripped (spaces, newlines from the end), and will be
# centered between * characters.
def printReportHeader(headline, skipNewLine = 1):
    headline = headline.rstrip()
    headline = headline.lstrip()
    headline = " " + headline + " "
    lineToPrint = string.center(headline, 80, "*")
    if skipNewLine != 0 :
        lineToPrint = "\n" + lineToPrint
    print lineToPrint
    sys.stdout.flush()


################################################################################
### PROC filesystem related methods
################################################################################

# this method opens the /proc/cpuinfo file, and extracts the cpu related info
# from it. returns a hash, which will be in respect with the cpu-related info
# provided by the VDSM caps.py tool.
def getProcCpuInfo():
    retVal = {}
    retVal["cpuModel"] = ""
    retVal["cpuSpeed"] = ""
    retVal["cpuSockets"] = ""
    retVal["cpuCores"] = ""
    retVal["cpuThreads"] = ""
    retVal["cpuFlags"] = ""

    numProcs = 0
    numSiblings = 0

    try:
        proc_cpu_info = open(cpuinfoFile, "r")
    except:
        sys.stderr.write("Unable to open " + cpuinfoFile + " file!")
        return retVal

    for line in proc_cpu_info:
        # CPU model name and speed
        match = re.match("^model\s+name\s+\:\s(.*)\s+@\s+(.*)$", line)
        if match:
            retVal["cpuModel"] = match.group(1)
            retVal["cpuSpeed"] = match.group(2)
        # CPU cores
        match = re.match("^cpu\s+cores\s+\:\s+(.*)$", line)
        if match:
            retVal["cpuCores"] = match.group(1)
        # CPU Threads (siblings)
        match = re.match("^siblings\s+\:\s+(.*)$", line)
        if match:
            retVal["cpuThreads"] = match.group(1)
            numSiblings = match.group(1)
        # CPU flags (flags)
        match = re.match("^flags\s+\:\s+(.*)$", line)
        if match:
            retVal["cpuFlags"] = match.group(1)
        # CPU count
        if re.match("^processor\s+\:\s+(.*)$", line):
            numProcs += 1
      
    # CPU sockets (socket = numProcs/numSiblings)
    try:
        retVal["cpuSockets"] = str(numProcs / int(numSiblings))
    except:
        retVal["cpuSockets"] = "0"

    proc_cpu_info.close()
    return retVal


# reads the /proc/meminfo file and extracts various information from it.
def getProcMemInfo():
    retVal = {"memTotal":"", "memFree":"", "swapTotal":"", "swapFree":""}

    try:
        mem_info_file = open(meminfoFile, "r")
    except:
        sys.stderr.write("Unable to open " + meminfoFile + " file!")
        return retVal

    for line in mem_info_file:
        # MemTotal
        match = re.match("^MemTotal\:\s+(.*)$", line)
        if match:
            retVal["memTotal"] = match.group(1)

        # MemFree
        match = re.match("^MemFree\:\s+(.*)$", line)
        if match:
            retVal["memFree"] = match.group(1)

        # SwapTotal
        match = re.match("^SwapTotal\:\s+(.*)$", line)
        if match:
            retVal["swapTotal"] = match.group(1)

        # SwapFree
        match = re.match("^SwapFree\:\s+(.*)$", line)
        if match:
            retVal["swapFree"] = match.group(1)


    mem_info_file.close()
    return retVal;


# reads the /proc/modules file, and the /proc/version file.
# returns in a hash, the kernel version and release, and the loaded modules.
def getProcModules():
    retVal = {"version":"", "release":"", "modules":""}

    # obtain the kernel version and release information.
    try:
        kernel_file = open(versionFile, "r")
    except:
        sys.stderr.write("Unable to open " + versionFile + " file!")
        return retVal

    kernel_line = kernel_file.readline()
    kernel_file.close()
    match = re.match("^Linux\sversion\s(.*?)\s(.*)$", kernel_line)
    if match:
        kernel_info = match.group(1).split("-", 1)
        retVal["version"] = kernel_info[0]
        retVal["release"] = kernel_info[1]

    # now process the list of modules
    try:
        modules_file = open(modulesFile, "r")
    except:
        sys.stderr.write("Unable to open " + modulesFile + " file!")
        return retVal

    tempList = []
    for line in modules_file:
        match = re.match("^(.*?)\s+(.*)$", line)
        if match:
            tempList.append(match.group(1))

    tempList.sort()
    retVal["modules"] = ', '.join(tempList)
    modules_file.close()

    return retVal


################################################################################
### DMIDECODE related methods
################################################################################
dmiDecodeValues = {
    'BIOS Information' : {
        'Vendor:' : '',
        'Version:': '',
        'Release Date:' : '',
        'BIOS Revision:' : ''
    },

    'System Information' : {
        'Manufacturer:' : '',
        'Product Name:' : '',
        'Version:' : '',
        'Serial Number:' : ''
    },

    'Built-in Pointing Device' : {
        'Type:' : '',
        'Buttons:' : '',
        'Interface:' : ''
    },

    'Base Board Information' : {
        'Manufacturer:' : '',
        'Product Name:' : '',
        'Serial Number:' : '',
    },

    'BIOS Language Information' : {
        'Currently Installed Language:' : ''
    },

}
dmiLines = ""


def processDmiDecodeValues():
    # create a random named file, and gather dmidecode returned lines into it
    char_set = string.ascii_uppercase + string.digits
    tmpFileName = "/tmp/" + ''.join(random.sample(char_set*6,6))

    try:
        tmpFile = open(tmpFileName, "w")
    except:
        print "Cannot create file: " + tmpFileName
        return

    command = "dmidecode"
    # execute dmidecode
    try:
        subprocess.check_call(command , shell=True, stderr=subprocess.STDOUT, universal_newlines=True, stdout=tmpFile)
    except subprocess.CalledProcessError:
        print "Error calling dmidecode!"
        return
  
    # close the file to flush the subprocess output into it,
    # and open it for readin
    tmpFile.close()

    try:
        tmpFile = open(tmpFileName, "r+")
    except:
        print "Cannot open file " + tmpFileName
        return

    # process each line....
    # The processing logic is the following:
    # getting from the dmiDecodeValues hash, the keys, and lookup that
    # key in the file.
    for dmiK1, dmiV1 in dmiDecodeValues.iteritems():
        tmpFile.seek(0,0) # rewind to position 0
        line = tmpFile.readline()
        while line:
            match = re.match("^"+dmiK1+"$", line)
            if match:
                # now we have a match, we found the requested category, so
                # we need to lookup the additional information(s)
                # get the current file position to be able to rewind to it
                masterKeyFilePosition = tmpFile.tell()
                # now lookup the next key in the following lines...
                for dmiK2, dmiV2 in dmiV1.iteritems():
                    # seek for the master key position
                    tmpFile.seek(masterKeyFilePosition, 0)
                    # read ahead and search for the sub-key
                    nextLine = tmpFile.readline()
                    while nextLine:
                        subMatch = re.match("^\s+"+dmiK2+"(.*)$", nextLine)
                        if subMatch:
                            dmiDecodeValues[dmiK1][dmiK2] = subMatch.group(1)
                            nextLine = None
                            break
                        # go to the next line
                        nextLine = tmpFile.readline()

            # read the next line, in search for master key
            line = tmpFile.readline()

    tmpFile.close()
    os.remove(tmpFileName)
# return from the method!


# this method prints out a hash of hash-es...
def printDmiDecodeValues(dmiDecVal, headline, footline, prefix):
    printReportHeader(headline)
    for dmiK1,dmiV1 in dmiDecVal.iteritems():
        print  "\n" + prefix + dmiK1
        for dmiK2,dmiV2 in dmiV1.iteritems():
            print "  " + prefix + dmiK2 + " " + dmiV2
    printReportHeader(footline, 0)


################################################################################
### lspci - data processing
################################################################################

# just a simple helper method, to read a single line from a file, and
# try to match a given regex on that line. returns the regex first field.
def readHelper(fileToReadFrom, regexPart):
    retV = ""
    line = fileToReadFrom.readline()
    match = re.match("^"+regexPart+":(.*)$", line)
    if match:
        retV = match.group(1)

    return retV


# runs and captures the lspci command output into a temporary file.
# after that processes the file, and returns a list of elements;
# the elements are simple hashes, which contains the Slot, Class, Vendor and
# Device information about a listed PCI device.
def getPciDevicesList():
    retVal = []
    # create a random named file, and gather lspic returned lines into it
    char_set = string.ascii_uppercase + string.digits
    tmpFileName = "/tmp/" + ''.join(random.sample(char_set*6,6))

    try:
        tmpFile = open(tmpFileName, "w")
    except:
        print "Cannot create file " + tmpFileName
        return retVal

    command = "lspci -mm -vvv -D"
    # execute lspci
    subprocess.check_call(command , shell=True, stderr=subprocess.STDOUT, universal_newlines=True, stdout=tmpFile)
  
    # close the file to flush the subprocess output into it,
    # and open it for readin
    tmpFile.close()

    try:
        tmpFile = open(tmpFileName, "r+")
    except:
        print "Cannot open file " + tmpFileName
        return retVal

    line = tmpFile.readline()
    while line:
        match = re.match("^Slot:\s+(.*)$", line)
        if match:
            pciDevice = {'Slot':'', 'Class':'', 'Vendor':'', 'Device':''}
            pciDevice["Slot"] = match.group(1)
            # now read ahead to gather the rest of the lines...
            pciDevice["Class"] = readHelper(tmpFile, "Class")
            pciDevice["Vendor"] = readHelper(tmpFile, "Vendor")
            pciDevice["Device"] = readHelper(tmpFile, "Device")
            retVal.append(pciDevice)

        # read ahead, is not a line in which we have interest
        line = tmpFile.readline()

    tmpFile.close()
    os.remove(tmpFileName)
    return retVal
# return from the getPciDeviceList() method


# prints the PCI device list informations.
def printPciDevicesList(pciDevices):
    printReportHeader("PCI Devices Information")

    for pciDev in pciDevices:
        print "\nPCI - Slot: " + pciDev["Slot"]
        print "PCI - Device: " + pciDev["Device"]
        print "PCI - Class: " + pciDev["Class"]
        print "PCI - Vendor: " + pciDev["Vendor"]

    printReportHeader("PCI Devices Info - Done", 0)


################################################################################
### HWLOC-info related data gathering
################################################################################

# prints localization topology data gathered using the hwloc-info package
def printHwlocInfoData():
    printReportHeader("HWLOC-INFO Topology Information")
    cmdLine = "lstopo"
    subprocess.call(cmdLine, shell=True)
    printReportHeader("HWLOC-INFO - Done")


################################################################################
### Kernel config options gathering....
################################################################################

# test if the /proc/config.gz file exists. if yes, then it will be read
# zcat /proc/config.gz, and the output will be shown between the
# tool header and footer....
def kernelConfigGathering():
    configFile = "/proc/config.gz"
    printReportHeader("KERNEL Configuration Information")
    if not os.path.exists(configFile):
        print "KERNEL Configuration Information - NOT PRESENT!"
    else:
        subprocess.call("zcat "+configFile, shell=True)

    printReportHeader("KERNEL Config Info - Done", 0)


################################################################################
### VDSM based info extraction
################################################################################

# this method is used to print out the CPU related informations, extracted by
# the VDSM package caps.py script.
def printCpuInfo(cHash):
    printReportHeader("CPU Information")
    if cHash == None: # don't have VDSM, get the info from /proc/cpuinfo
        cHash = getProcCpuInfo()
      
    print "CPU Model: " + cHash["cpuModel"]
    print "CPU Speed: " + cHash["cpuSpeed"]
    print "CPU Sockets: " + cHash["cpuSockets"]
    print "CPU Cores: " + cHash["cpuCores"]
    print "CPU Threads: " + cHash["cpuThreads"]
    print "CPU Flags: " + cHash["cpuFlags"]
   
    # create a list of cpu flags
    flagList = cHash["cpuFlags"].split()
    if "x2apic" in flagList:
        x2apic = " present"
    else:
        x2apic = " not present"

    if "vmx" in flagList:
        vtsupport = " present"
    else:
        vtsupport = " not present"

    print "CPU X2APIC Support:" + x2apic
    print "CPU VT Support:" + vtsupport
    # for VT-d support - IOMMU there is no linux flag present, so it cannot
    # be reported

    # still have to deal with cpu flags?
    printReportHeader("CPU Info - Done", 0)


# this method is used to display various hardware related informations
def printHwInfo(cHash):
    printReportHeader("HARDWARE Information")
    if cHash != None: # if we have vdsm, report it from vdsm
        print "HARDWARE - KVM enabled: " + cHash["kvmEnabled"]
        print "HARDWARE - MEMORY Size: " + cHash["memSize"]
        print "HARDWARE - MEMORY Reserved: " + cHash["reservedMem"]

    # display memory related information
    memInfoHash = getProcMemInfo()
    print "HARDWARE - MEMORY Total: " + memInfoHash["memTotal"]
    print "HARDWARE - MEMORY Free: " + memInfoHash["memFree"]
    print "HARDWARE - MEMORY Swap Size: " + memInfoHash["swapTotal"]
    print "HARDWARE - MEMORY Swap Free: " + memInfoHash["swapFree"]

    printReportHeader("HARDWARE Info - Done", 0)


# print OS related information - name, version and release
def printOsInfo(cHash):
    printReportHeader("OS Information")
    if cHash != None: # if we have vdsm, report it from vdsm
        osHash = cHash["operatingSystem"]
        print "OS Name: " + osHash["name"]
        print "OS Version: " + osHash["version"]
        print "OS Release: " + osHash["release"]
    else:
        print "No info! VDSM not present...."
    printReportHeader("OS Info - Done", 0)


# print KERNEL related information - version and release
def printKernelInfo(cHash):
    printReportHeader("KERNEL Information")
    if cHash != None: # if we have vdsm, report it from vdsm
        kernelInfo = cHash["packages2"]["kernel"]
        print "KERNEL Version: " + kernelInfo["version"]
        print "KERNEL Release: " + kernelInfo["release"]
    #else:
    kernelInfo = getProcModules()
    print "KERNEL Version: " + kernelInfo["version"]
    print "KERNEL Release: " + kernelInfo["release"]
    print "KERNEL Modules: " + kernelInfo["modules"]
    printReportHeader("KERNEL Info - Done", 0)


# print VDSM related information - version and release
# also prints the supported engine versions
def printVdsmInfo(cHash):
    printReportHeader("VDSM Information")
    if cHash != None: # if we have vdsm, report it from vdsm
        vdsmInfo = cHash["packages2"]["vdsm"]
        print "VDSM Version: " + vdsmInfo["version"]
        print "VDSM Release: " + vdsmInfo["release"]

        # format the supported engines...
        supportedEngines = " ";
        for idx in cHash["supportedENGINEs"]:
            supportedEngines += idx.rstrip() + ", "
        supportedEngines = supportedEngines[:-2]
        print "VDMS Supported Engines: " + supportedEngines
    else:
        print "No info! VDSM not present...."
    printReportHeader("VDSM Info - Done", 0)


# print QEMU-KVM related information - version and release
def printQemuInfo(cHash):
    printReportHeader("QEMU-KVM Information")
    if cHash != None: # if we have vdsm, report it from vdsm
        qemuInfo = cHash["packages2"]["qemu-kvm"]
        print "QEMU-KVM Version: " + qemuInfo["version"]
        print "QEMU-KVM Release: " + qemuInfo["release"]
    else:
        print "No info! VDSM not present...."
    printReportHeader("QEMU-KVM Info - Done", 0)


# print LIBVIRT related information - version and release
def printLibvirtInfo(cHash):
    printReportHeader("LIBVIRT Information")
    if cHash != None: # if we have vdsm, report it from vdsm
        libvirtInfo = cHash["packages2"]["libvirt"]
        print "LIBVIRT Version: " + libvirtInfo["version"]
        print "LIBVIRT Release: " + libvirtInfo["release"]
    else:
        print "No info! VDSM not present...."
    printReportHeader("LIBVIRT Info - Done", 0)

# print SPICE related information - version and release
def printSpiceInfo(cHash):
    printReportHeader("SPICE Information")
    if cHash != None: # if we have vdsm, report it from vdsm
        spiceInfo = cHash["packages2"]["spice-server"]
        print "SPICE Version: " + spiceInfo["version"]
        print "SPICE Release: " + spiceInfo["release"]
    else:
        print "No info! VDSM not present...."
    printReportHeader("SPICE Info - Done", 0)



###############################################################
### Show help
###############################################################
def printUsage():
    printReportHeader("Tool Usage")
    print "\nUsage:"
    print "\t" + sys.argv[0] + " <options>"
    print "\nWhere options:\n"
    print "\t -h | --help = display this help message"
    print "\t -c | --cpushow = shows CPU information"
    print "\t -H | --hardware = shows various hardware related information"
    print "\t -o | --os = shows Operating System related information (only if VDSM present)"
    print "\t -k | --kernel = shows kernel related information"
    print "\t -v | --vdsm = shows VDSM related information (only if VDSM present)"
    print "\t -q | --qemu = shows QEMU related information (only if VDSM present)"
    print "\t -l | --libvirt = shows libvirt related information (only if VDSM present)"
    print "\t -s | --spice = shows spice related information (only if VDSM present)"
    print "\t -L | --localization = shows lstopo (hwloc-info) topology information"
    print "\t -d | --dmi = shows dmidecode provided information"
    print "\t -p | --pci = shows pci related information"
    print "\t -K | --Kconfig = shows kernel configuration information"
    print "\t -a | --all = shows all the information that can be gathered"
    printReportHeader("Bye")


###############################################################
### MAIN LOGIC
###############################################################

def main(argv):
    try:
        opts, args = getopt.getopt(argv, "hcHokvqlsdpKLa",
        ["help", "cpushow", "hardware", "os", "kernel", "vdsm",
        "qemu", "libvirt", "spice", "dmi", "pci", "Kconfig", "localization", "all"])
    except getopt.GetoptError:
        printUsage()
        sys.exit(10)

    # at least one command line flag shall be present
    if len(opts) == 0:
        printUsage()
        sys.exit(11)

    # initialize required data structures with various informations.
    if vdsmPresent == True:
        capabilityHash = caps.get()
    else:
        capabilityHash = None

    processDmiDecodeValues()
    pciDevices = getPciDevicesList()
  
    # check if -a | --all is present in the cmd line...
    for opt,arg in opts:
        if opt in ("-a", "--all"):
            opts = []
            for o1 in list("cHokvqlsLdpK"):
                t1 = ("-"+o1, "") # create the tuple to add to the list...
                opts.append(t1)

    # now, process the rest of the command line parameters...
    for opt,arg in opts:
        if opt in ("-h", "--help"):
            printUsage()
            sys.exit(0)
        elif opt in ("-c", "--cpushow"):
            printCpuInfo(capabilityHash)
        elif opt in ("-H", "--hardware"):
            printHwInfo(capabilityHash)
        elif opt in ("-o", "--os"):
            printOsInfo(capabilityHash)
        elif opt in ("-k", "--kernel"):
            printKernelInfo(capabilityHash)
        elif opt in ("-v", "--vdsm"):
            printVdsmInfo(capabilityHash)
        elif opt in ("-q", "--qemu"):
            printQemuInfo(capabilityHash)
        elif opt in ("-l", "--libvirt"):
            printLibvirtInfo(capabilityHash)
        elif opt in ("-s", "--spice"):
	    printSpiceInfo(capabilityHash)
        elif opt in ("-L", "--localization"):
            printHwlocInfoData()
        elif opt in ("-d", "--dmi"):
            printDmiDecodeValues(dmiDecodeValues,
            "DMI Decoded Information",
            "DMI Info - Done",
            "DMI - ")
        elif opt in ("-p", "--pci"):
            printPciDevicesList(pciDevices)
        elif opt in ("-K", "--Kconfig"):
            kernelConfigGathering()

if __name__ == "__main__":
    main(sys.argv[1:])

sys.exit(0)

