#!/bin/sh

# Assume we have the CA cert.

# source target info
#
. /opt/cut/ipsec-strongswan/ipsec_cut_config.sh


# Now, generate "host" info for each target that goes in /etc/ipsec.d/certs.
#
pki --gen > ${lclName}Key.der
pki --pub --in ${lclName}Key.der | pki --issue --lifetime 730 \
          --cacert strongswanCert.der --cakey strongswanKey.der \
          --dn "C=CH, O=strongSwan, CN=${lclName}.strongswan.org" \
          --san ${lclIP} \
          > ${lclName}Cert.der
          
pki --print --in ${lclName}Cert.der

pki --gen > ${rmtName}Key.der
pki --pub --in ${rmtName}Key.der | pki --issue --lifetime 730 \
          --cacert strongswanCert.der --cakey strongswanKey.der \
          --dn "C=CH, O=strongSwan, CN=${rmtName}.strongswan.org" \
          --san ${rmtIP} \
          > ${rmtName}Cert.der
          
pki --print --in ${rmtName}Cert.der
