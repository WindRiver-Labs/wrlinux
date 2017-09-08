#!/bin/sh

# Generate ipsec.conf for both targets

# source target info
#
. /opt/cut/ipsec-strongswan/ipsec_cut_config.sh

cat > ipsec.conf << EOF
# /etc/ipsec.conf - strongSwan IPsec configuration file

config setup

conn %default
	ikelifetime=60m
	keylife=20m
	rekeymargin=3m
	keyingtries=1
	keyexchange=ikev2
	authby=secret
	
conn toRemote
	left=${lclIP}
	#leftcert=${lclName}Cert.der
	leftfirewall=yes
	right=${rmtIP}
	#rightcert=${rmtName}Cert.der
	auto=add

conn fromLocal
	left=${rmtIP}
	#leftcert=${rmtName}Cert.der
	leftfirewall=yes
	right=%any
	#rightcert=${lclName}Cert.der
	rightsubnet=${lclIP}/32
	auto=add
EOF
