#!/bin/sh

# Assume we have the CA cert.

# source target info
#
. /opt/cut/ipsec-strongswan/ipsec_cut_config.sh


# Now, generate "host" info for each target that goes in /etc/ipsec.d/certs.
#
ipsec pki --gen > ${lclName}Key.der
ipsec pki --pub --in ${lclName}Key.der | ipsec pki --issue --lifetime 730 \
          --cacert strongswanCert.der --cakey strongswanKey.der \
          --dn "C=CH, O=strongSwan, CN=${lclName}.strongswan.org" \
          --san ${lclIP} \
          > ${lclName}Cert.der
          
ipsec pki --print --in ${lclName}Cert.der

ipsec pki --gen > ${rmtName}Key.der
ipsec pki --pub --in ${rmtName}Key.der | ipsec pki --issue --lifetime 730 \
          --cacert strongswanCert.der --cakey strongswanKey.der \
          --dn "C=CH, O=strongSwan, CN=${rmtName}.strongswan.org" \
          --san ${rmtIP} \
          > ${rmtName}Cert.der
          
ipsec pki --print --in ${rmtName}Cert.der
