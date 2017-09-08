
# Generate stuff for /etc/ipsec.d/cacerts.  This (probably) must be on
# each target.
#
ipsec pki --gen -s 4096 > strongswanKey.der
ipsec pki --self --ca --lifetime 1460 --in strongswanKey.der \
          --dn "C=CH, O=strongSwan, CN=strongSwan Root CA" \
          > strongswanCert.der
          
# Dump the info.
#
ipsec pki --print --in strongswanCert.der

