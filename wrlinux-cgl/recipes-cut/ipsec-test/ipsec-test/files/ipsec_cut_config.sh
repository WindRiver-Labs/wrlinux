# source this file in strongswan CUT scripts
#

# uncomment one of these before running the test script
#
IPSEC_CUT_MODE="skip"
#IPSEC_CUT_MODE="run"

# set these as appropriate before generating the target
# certificates and ipsec.conf
#
lclIP=192.168.7.2
lclName="local"

rmtIP=192.168.7.4
rmtName="remote"
