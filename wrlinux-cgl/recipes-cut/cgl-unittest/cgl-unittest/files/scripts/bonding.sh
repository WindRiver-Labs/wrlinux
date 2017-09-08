#!/bin/bash
#Copyright (c) 2008 Wind River Systems, Inc.
#description :bonding basic test
#
#developer :
#      09/6/2      Yongli He  <yongli.he@windriver.com>
#      2009-05-01   Joe MacDonald
#
# changelog
# *
# -
#***********************************************************************

TOPDIR=${CUTDIR-/opt/cut/}
. $TOPDIR/function.sh




# config bond_if(a ethx name list) as slave, bond_ip as bond interface ip, ping the bond_host
bond_if=""  # list
bond_ip=""


#the target's ip list and mask
self_ip=""  #list
self_mask=""

# host probe result
bond_hosts=$HOST_IP_ADDRV4  #list

tmpf=hosts.tmp


clean()
{
   echo "Cleaning up bonding basic test..."
   for i in $bond_if
   do
      ifenslave -d bond0 $i
   done
   rmmod bonding
   rm -rf $tmpf
   echo  "Exit bonding basic test "
}


help()
{
   echo " "
   echo "   Manual execution required."
   echo " "
   echo "   This test configures a bonded interface for adaptive load balancing,"
   echo "   which requires all bonded ethernet devices to support rewriting the"
   echo "   MAC address while the device is open.  Currently the following devices"
   echo "   are known not to work:"
   echo " "
   echo "   - 3c59x"
   echo "   - gianfar"
   echo "   - tulip"
   echo "   - via-rhine"
   echo "                                                                 "
   echo "   If your target uses one of these drivers, this test is expected to fail."
   echo " "
   echo "   If your target does not use one of these, a good indication is to examine"
   echo "   the driver code for the device used by your target.  Look for the function"
   echo "   being assigned to the dev->set_mac_address field in the net_device"
   echo "   structure, or for dev->ndo_set_mac_address in the net_device_ops"
   echo "   structure.  Examination of that function should indicate whether the support"
   echo "   for rewriting the MAC address while the device is open is there."
   echo " "
   echo "   If the test fails when executed automatically, you can retry the test manually."
   echo " "
   echo "   on the target create a simple script similar to the following:"
   echo " "
   echo "   #!/bin/bash"
   echo "   modprobe bonding mode=balance-alb miimon=100"
   echo "   ifconfig bond0 TARGET_IP netmask 255.255.255.0 up"
   echo "   ifenslave bond0 TARGET_ETH"
   echo "   ping HOST_IP_ADDRV4"
   echo " "
   echo "   - replace TARGET_IP with an IP address on the target.  This will be assigned"
   echo "     to the bonded interface"
   echo "   - replace TARGET_ETH with the name of the interface on the target to use"
   echo "   - replace HOST_IPADDRV4 with the IP address of the host"
   echo " "
   echo "   Execute this script.  The test is successful if the ping succeeds."
   echo "  "
}

find_running_interfaces() {
local eth_list
local found

eth_list=`ifconfig -a | grep "Link encap:Ethernet" | cut -d" " -f1`

for eth in $eth_list ; do
	found=0
	if [ "`ethtool $eth | grep Link | cut -d : -f2`" = " yes" ] ; then 
		echo "$eth is active"
		for eth_used in $if_all ; do
			if [ "$eth" = "$eth_used" ] ; then 	
				found=1
				break
			fi
		done
		if [ $found -eq 0 ]; then
                  ip_t=$(ifconfig $eth | grep 'inet addr:' |awk '{ print $2 }' | awk   '{print $1 }' | awk -F: '{ print $2 }')
		  if [ ! "$ip_t" ]; then
		    bond_if+="$eth "
                  fi
		fi
        fi
done


}

get_statistics() {
  interface=$1
  ETH_STAT=`ifconfig $interface | grep "TX packets"`
  let ETH_TX=0
  for i in 2 3 4 5 6 ; do
    let X=`echo $ETH_STAT | cut -d ":" -f${i} | cut -d " " -f1`
    let ETH_TX+=$X
    #echo $X
  done

  echo "${ETH_TX}"
  #return ${ETH_TX} will only up to 255
}

bond_balance_round_robin_test() {
  rmmod bonding
  modprobe bonding mode=0 miimon=100
  BOND_NAME=bond0
  ifconfig $BOND_NAME 192.168.1.1 netmask 255.255.255.0 up
  let interface_num=0
  for eth in $bond_if; do
    ifenslave $BOND_NAME $eth
    let interface_num+=1
  done
  
  for eth in $bond_if; do
    ifconfig $eth up
  done
  #tcpdump -i $BOND_NAME &
  echo "Wait 5 seconds to let stack send some packets..."
  sleep 5
  
  stat_list=""
  for eth in $bond_if; do
    let ETH_TX_BEFORE=`get_statistics $eth`
    echo "${eth}=${ETH_TX_BEFORE}"
    stat_list+="$ETH_TX_BEFORE "
  done
    echo "before=$stat_list"
  
  let packet_inc=4
  let packet_cnt=${interface_num}*${packet_inc}
  arp -i $BOND_NAME -s 192.168.1.2 00:00:01:04:05:06
  ping -c $packet_cnt -I $BOND_NAME 192.168.1.2
  
  stat_after_list=""
  for eth in $bond_if; do
    let ETH_TX_AFTER=`get_statistics $eth`
    echo "${eth}=${ETH_TX_AFTER}"
    stat_after_list+="$ETH_TX_AFTER "
  done
  
  echo "after=$stat_after_list"
  
  stat_before_list=""
  for stat in $stat_list; do
    let stat+=$ETH_TX_AFTER-$ETH_TX_BEFORE 
    #don't use ${packet_inc}, just in case there
    #are some even number of packets sending out by stack
    stat_before_list+="$stat "
  done
  
  if [ "$stat_before_list" = "$stat_after_list" ]; then
     return 0
  fi
  
  return 1
}

bond_balance_round_robin_test_cleanup() {
  arp -i $BOND_NAME -d 192.168.1.2
  ifconfig $BOND_NAME 0.0.0.0
}
#############################################################################
#probe origin IP, mask and one or two up-with-no-ip ethnet interface
#############################################################################
if_all=$(ifconfig | grep "Link encap:Ethernet" | awk '{print $1}' | xargs)

if_num=`echo $if_all|wc -w`
if [ $if_num -lt 2 ]; then
	cutna "Not enough NICs on target"
fi

echo "all active ethernet interfaces: $if_all"

# find an active interface with no ip address (select the non NFS interface)
for eth in $if_all
do 
   ip_t=$(ifconfig $eth | grep 'inet addr:' |awk '{ print $2 }' | awk   '{print $1 }' | awk -F: '{ print $2 }')
   ip_mask=$(ifconfig $eth | grep 'inet addr:' |awk '{ print $4 }' | awk   '{print $1 }' | awk -F: '{ print $2 }')

   if [ ! "$ip_t" ]
   then  # no ip address
      bond_if+="$eth "
   else # with avaliable ip address
      self_ip+=$ip_t
      self_mask=$ip_mask  # only one mask is ok
   fi
done

if [ "X$bond_if" = "X" ]; then
  #try find running interfaces but not up
  find_running_interfaces
fi

# ensure we have at least one suitable interface to bond to
if [ "X$bond_if" = "X" ]
then
   echo "*****************************************************"
   echo "At least one interface is required to be up without "
   echo "having an IP address configured."
   echo "Activate an interface and restart test."
   echo "List of interfaces:"
   echo "-----------------------------------------------------"
   ifconfig -a
   echo "*****************************************************"
   cutfail
fi

echo "self ip list: $self_ip, bond if list: $bond_if "

# END probe self ip


#####################################
# select host
#####################################
bcast_addr=`ifconfig | grep Bcast | cut -d ':' -f 3 | awk '{print $1}'`
for host in $bcast_addr
do
   echo "checking bcast addr $host"
   bond_hosts+=`ping -b $host -c 2 -s 56 2>&1 | grep "64 bytes from" | awk '{ print $4 }' | awk -F ':' '{ print $1 }'`
done

if [ "X$bond_hosts" = "X" ]
then
   echo "*****************************************************"
   echo "Failed to identify a broadcast address for target"
   echo "List of interfaces:"
   echo "-----------------------------------------------------"
   ifconfig -a
   echo "*****************************************************"
   help
   cutfail
fi

# drop off hosts not on our subnet, based on a /24 subnet
rm -rf $tmpf
touch $tmpf
for h in $bond_hosts
do
   for s in $self_ip
   do
      #echo "${s%.*}" "${h%.*}"
      if [ "${s%.*}" = "${h%.*}" ] ; then
         echo $h >> $tmpf
      fi
   done
done

bond_hosts=$(cat $tmpf | sort -u)

#end probe local host


############################################################
# select a "local unique ip" as bind_ip
# try eachip+1 then cmp it with all known host ip
############################################################
let ok=1
#echo $self_ip $bond_hosts
for h in $bond_hosts
do
   let ok=1
   last_digtal=$(echo $h | awk -F "." '{print $4}')
   let last_digtal+=1
   echo "probe: ${h%.*}.$last_digtal"

   for i in $self_ip $bond_hosts  #cmp guess ip with all known host
   do
      #echo $i == ${h%.*}.$last_digtal
      if [ "$i" = "${h%.*}.$last_digtal" ] ; then
           let ok=0
           break
      fi
   done
   if (( $ok == 1 )) ; then  # diffrent with very one, safe for tmp use
      bond_ip=${h%.*}.$last_digtal
      break
   fi
done

echo "bond_ip: $bond_ip ok:$ok"

#end probe

########################
#final check :
########################
echo "bond_if: $bond_if, bond_ip: $bond_ip, bond_hosts: $bond_hosts  self_mask: $self_mask"

if [ ! "$bond_hosts" ]
then
   echo "*****************************************************"
   echo "Please set your host IP address (the address to which"
   echo "the target will ping) on the target by"
   echo "executing the following:"
   echo "> export HOST_IP_ADDRV4={your host ip address}"
   echo "and then rerun test."
   echo "*****************************************************"
   cutfail
fi

if [ ! "$bond_if" ]
then
   echo "*****************************************************"
   echo "Cannot identify an interface whose state is up and"
   echo "has no IP address configured.  Please verify target"
   echo "connectivity and rerun testsuite, or test manually"
   echo "-----------------------------------------------------"
   help
   echo "*****************************************************"
   cutfail
fi

if [ ! "$bond_ip" ] || [ ! "$self_mask" ]
then
   echo "*****************************************************"
   echo "Cannot determine an IP address for bond interface."
   echo "-----------------------------------------------------"
   help
   echo "*****************************************************"
   cutfail
fi

for eth in $bond_if
do
	driver='ethtool -i $eth|grep octeon'
	if [ -n "$driver" ]
	then
		ignor_balance_alb=1
	fi
done

if [ "X$ignor_balance_alb" == "X" ]
then
#install mod, create bond0
echo "loading module..."
modprobe bonding mode=balance-alb miimon=100
if [ ! $? = 0 ]; then 
   echo "*****************************************************"
   echo "Failed to load bonding module:"
   echo "-----------------------------------------------------"
   dmesg | grep bonding
   echo "*****************************************************"
   cutfail
fi


#config bond0
ifconfig bond0 $bond_ip netmask $self_mask up

#add 1-2 interfaces to bond0
num=0
for eth in $bond_if
do
   if [ ! "$eth" = "lo" ] && (( $num<=2 )) ; then
      ifenslave bond0 $eth
      if [ $? = 0 ]
      then
         let num+=1
      fi
   fi
done

# ensure we've enslaved at least one interface to the bond
if [ "$num" = 0 ]
then
   echo "*****************************************************"
   echo "Failed to enslave any interface to the bond interface"
   echo "-----------------------------------------------------"
   dmesg | tail -n 20
   echo "-----------------------------------------------------"
   help
   echo "*****************************************************"
   cutfail
fi

num=0
for h in $bond_hosts
do
   ping -I bond0 -c 4 $h
   if [ $? = 0 ] ; then
      echo "Pass $h"
   else
     #just in case that bond0 has the same subnet ip with self_ip
     #disable rpf on bond0
     rpf=`cat /proc/sys/net/ipv4/conf/bond0/rp_filter`
     if [ $rpf -ne 0 ]; then
       echo 0 > /proc/sys/net/ipv4/conf/bond0/rp_filter
       ping -I bond0 -c 4 $h
       if [ $? = 0 ] ; then
         echo "Pass to ping $h via bond0 with rpf enabled"
       else
         echo "Failed to ping $h via bond0"
         let num+=1
       fi
       echo $rpf > /proc/sys/net/ipv4/conf/bond0/rp_filter
     else
       echo "Failed to ping $h via bond0 with rpf enabled already"
       let num+=1
     fi
   fi
done

if [ $num -ne 0 ]; then
  echo "*****************************************************"
  echo "Failed to ping host from target via bonded interface"
  echo "It might be bond interface not connected to nfs network"
  echo "-----------------------------------------------------"
  help
  echo "*****************************************************"
  #cutfail
fi
fi
bond_balance_round_robin_test
ret=$?
bond_balance_round_robin_test_cleanup
if [ $ret -ne 0 ]; then
  echo "*****************************************************"
  echo "Failed to test round-robin mode for bonded interface"
  echo "It can be that stack sends out some other packets via\
        bond interface that caused we calculate wrong statistics"
  echo "*****************************************************"
  cutfail
fi

cutpass
