#!/bin/sh

CONFDIR=/etc
killall -q hs
rm $CONFDIR/hotspot_ap* 1>/dev/null 2>&1

BSSIDNUM=`nvram_get 2860 BssidNum`
conf_list=

getValue()
{
	export IFS=";"
	idx=0
	word=
	for word in $1; do
		if [ $2 -eq $idx ]; then
			break
		else
			word=
		fi
		idx=`expr $idx + 1`
	done
	export IFS=" "
}

createNAI()
{
	echo "nai_realm_data={
	nai_realm=$1" >> $3
	temp=`echo $2 | sed 's/eap-tls//'`
	if [ "$temp" != "" ]; then
		echo "        eap_method=eap-ttls
	auth_param=2:4
        auth_param=5:7" >> $3
	fi
	temp=`echo $2 | sed 's/eap-ttls//'`
	if [ "$temp" != "" ]; then
		echo "        eap_method=eap-tls
        auth_param=5:6" >> $3
	fi
	echo "}" >> $3
}

create3GPP()
{
	echo "plmn={
	mcc=$1
	mnc=$2
}" >> $3
}

num=0
while [ $num -lt $BSSIDNUM ]
do
	ALLVALUE=`nvram_get 2860 AuthMode`
	getValue "$ALLVALUE" $num
	Security="$word"
	ALLVALUE=`nvram_get 2860 WscModeOption`
	getValue "$ALLVALUE" $num
	WPS="$word"
	ALLVALUE=`nvram_get 2860 HS_enabled`
	getValue "$ALLVALUE" $num
	HSenable="$word"
	if [ "$Security" != "WPA2" -o "$WPS" == "7" -o "$HSenable" != "1" ]; then
		num=`expr $num + 1`
		continue
	fi

	# interface=ra0
	interface="ra$num"
	# internet=0
	ALLVALUE=`nvram_get 2860 HS_internet`
	getValue "$ALLVALUE" $num
	internet="$word"
	# hessid=bssid
	ALLVALUE=`nvram_get 2860 HS_hessid`
	getValue "$ALLVALUE" $num
	hessid="$word"
	# roaming_consortium_oi=50-6F-9A,00-1B-C5-04-BD
	ALLVALUE=`nvram_get 2860 HS_roaming_consortium_oi`
	getValue "$ALLVALUE" $num
	roaming_consortium_oi="$word"
	echo "##hospot2.0 ap configuration file##

# Interface
# network interface name
interface=$interface

# Interworking
# 0: Disable
# 1: Enable
interworking=1

# Access Network Type
# 0: Private network
# 1: Private network with guest access
# 2: Chargeable public network
# 3: Free public network
# 4: Personal Device Network
# 5: Emergency Services Only Network
# 6-13: Reserved
#14: Test or experimental
#15: Wildcard
access_network_type=2

# Internet
# 0: Do not have connectivity to the Internet
# 1: The network provides connectivity to the Internet
internet=$internet

# Venue Group
# 0: Unspecified
# 1: Assembly
# 2: Business
# 3: Eductional
# 4: Factory and Industrial
# 5: Institutional
# 6: Mercantile
# 7: Residentail
# 8: Storage
# 9: Utility and Miscellaneous
#10: Vehicular
#11: Outdoor
#12-255 : Reserved
venue_group=2

# Venue Type
# Unspecified
#	0: Unspecified
#	1-255: Reserved
# 
# Assembly
#	0: Unspecified ssembly
#	1: Arena
#	2: Stadium
#	3: Passenger Terminal (e.g airport, bus, ferry, train station)
#	4: Amphitheater
#	5: Amusement Part
#	6: Place of Worship
#	7: Convention Center
#	8: Library
#	9: Museum
#  10: Restaurant
#  11: Theater
#  12: Bar
#  13: Coffee Shop
#  14: Zoo or Aquarium
#  15: Emergency COordination Center
#  16-255: Reserved
# Business
#	0: Unspecified Business
#	1: Doctor or Dentist office
#	2: Bank
#	3: Fire Station
#	4: Police Station
#	5: Reserved
#	6: Post Office
#	7: Professtional Office
#	8: Research and Development Facility
#	9: Attorney Office
#	10-255: Reserved
# Eductional
#	0: Unspecified Educational
#	1: School, Primary
#	2: School, Secondary
#	3: University or College
#	4-255: Reserved
# Factory and Industrial	
#	0: Unspecified Factory and INdustrial
#	1: Factory
#	2-255: Reserved
# Institutional
#	0: Unspecified Institutional
#	1: Hospital
#	2: Long-Term Care Facility
#	3: Alcohol and Drug Re-habilitation Center
#	4: Group Home
#	5: Prison or Jail
#	6-255: Reserved
# Mercantile
#	0: Unspecified Mercantile
#	1: Retail Store
#	2: Grocery Market
#	3: Automotive Serive Station
#	4: Shopping Mall
#	5: Gas Station
#	6-255: Reserved
# Residentail
#	0: Unspecified Residentail
#	1: Private Residence
#	2: Hotel or Motel
#	3: Dormitory
#	4: Boarding House
#	5-255: Reserved
# Storage
#	0: Unspecified Storage
#	1-255: Reserved
# Utility and Miscellaneous
#	0: Unspecified Utility and Miscellaneous
#	1-255: Reserved
# Vehicular
#	0: Unspecified Vehicular
#	1: Automobile or Truck
#	2: Airplane
#	3: Bus
#	4: Ferry
#	5: Ship or Boat
#	6: Train
#	7: Motor Bike
#	8-255: Reserved
# Outdoor
#	0:Unspecified Outdoor
#	1: Muni-mesh Network
#	2: City Park
#	3: Rest Area
#	4: Traffic Control
#	5: Bus Stop
#	6: Kiosk
#	7-255: Reserved
venue_type=8

# ANQP Query
# Enabled(1)/Disabled(0)
anqp_query=1

# MIH Information Service Advertisement Protocol
mih_support=0

# Venue Name
# language,name
venue_name=eng%{Wi-Fi Alliance
2989 Copper Road
Santa Clara, CA 95051, USA}
venue_name=chi%{Wi-Fi联盟实验室
二九八九年库柏路
圣克拉拉, 加利福尼亚95051, 美国}
	"  > $CONFDIR/hotspot_ap_$interface.conf
	
	if [ "$$hessid" != "" ]; then
		echo "hessid=$hessid" >> $CONFDIR/hotspot_ap_$interface.conf
	fi
	if [ "$roaming_consortium_oi" != "" ]; then
		echo "
roaming_consortium_oi=$roaming_consortium_oi" >> $CONFDIR/hotspot_ap_$interface.conf
	fi
	echo "

# Advertisement Protocol ID
# 0: Access Network Query Protocol
# 1: MIH Information Service
# 2: MIH Command and Event Service Capability Discovery
# 3: Emergency Alert System(EAS)
# 4-220 : Reserved
# 221: Vendor Specific
# 222-255: Reserved
advertisement_proto_id=0

domain_name=wi-fi.org

# Network Autentication Type
# Network Authentication Type Indicator;Re-direct URL
network_auth_type=0,https://tandc-server.wi-fi.org

# IPv4Type
# 0: Address type not available
# 1: Public IPv4 address available
# 2: Port-restricted IPv4 address available
# 3: Single NATed private IPv4 address available
# 4: Double NATed private IPv4 address available
# 5: Port-restricted IPv4 address and single NATed IPv4 address available
# 6: Port-restricted IPv4 address and double NATed IPv4 address available
# 7: Availability of the address type in not known
# 8-63: Reserved
ipv4_type=3

# IPv6TYpe
# 0: Address type not available
# 1: Address type available
# 2: Availability of the address type not known
# 3: Reserved
ipv6_type=0
" >> $CONFDIR/hotspot_ap_$interface.conf

	# NAI Realm list
	echo "# NAIRealmData" >> $CONFDIR/hotspot_ap_$interface.conf
	ALLVALUE=`nvram_get 2860 HS_nai1_realm`
	getValue "$ALLVALUE" $num
	nai_realm="$word"
	if [ "$nai_realm" != "" ]; then
		ALLVALUE=`nvram_get 2860 HS_nai1_eap_method`
		getValue "$ALLVALUE" $num
		eap_method="$word"
		createNAI $nai_realm $eap_method $CONFDIR/hotspot_ap_$interface.conf
	fi
	ALLVALUE=`nvram_get 2860 HS_nai2_realm`
	getValue "$ALLVALUE" $num
	nai_realm="$word"
	if [ "$nai_realm" != "" ]; then
		ALLVALUE=`nvram_get 2860 HS_nai2_eap_method`
		getValue "$ALLVALUE" $num
		eap_method="$word"
		createNAI $nai_realm $eap_method $CONFDIR/hotspot_ap_$interface.conf
	fi
	ALLVALUE=`nvram_get 2860 HS_nai3_realm`
	getValue "$ALLVALUE" $num
	nai_realm="$word"
	if [ "$nai_realm" != "" ]; then
		ALLVALUE=`nvram_get 2860 HS_nai3_eap_method`
		getValue "$ALLVALUE" $num
		eap_method="$word"
		createNAI $nai_realm $eap_method $CONFDIR/hotspot_ap_$interface.conf
	fi
	ALLVALUE=`nvram_get 2860 HS_nai4_realm`
	getValue "$ALLVALUE" $num
	nai_realm="$word"
	if [ "$nai_realm" != "" ]; then
		ALLVALUE=`nvram_get 2860 HS_nai4_eap_method`
		getValue "$ALLVALUE" $num
		eap_method="$word"
		createNAI $nai_realm $eap_method $CONFDIR/hotspot_ap_$interface.conf
	fi

	# WAN Metrics
	# link_status=1
	ALLVALUE=`nvram_get 2860 HS_link_status`
	getValue "$ALLVALUE" $num
	link_status="$word"
	# at_capacity=0
	ALLVALUE=`nvram_get 2860 HS_capacity`
	getValue "$ALLVALUE" $num
	at_capacity="$word"
	# dl_speed=2500
	ALLVALUE=`nvram_get 2860 HS_dl_speed`
	getValue "$ALLVALUE" $num
	dl_speed="$word"
	# ul_speed=384
	ALLVALUE=`nvram_get 2860 HS_ul_speed`
	getValue "$ALLVALUE" $num
	ul_speed="$word"
	# dl_load=0
	ALLVALUE=`nvram_get 2860 HS_dl_load`
	getValue "$ALLVALUE" $num
	dl_load="$word"
	# up_load=0
	ALLVALUE=`nvram_get 2860 HS_ul_load`
	getValue "$ALLVALUE" $num
	up_load="$word"
	# lmd=0
	ALLVALUE=`nvram_get 2860 HS_lmd`
	getValue "$ALLVALUE" $num
	lmd="$word"
	echo "

# Following are HS2.0 ANQP response #
# OperatorFirendName
op_friendly_name=eng,Wi-Fi Alliance
op_friendly_name=chi,Wi-Fi联盟

# Connection Capability
proto_port={
	ip_protocol=1
	port=0
	status=0
}
proto_port={
	ip_protocol=6
	port=20
	status=1
}
proto_port={
	ip_protocol=6
	port=22
	status=0
}
proto_port={
	ip_protocol=6
	port=80
	status=1
}
proto_port={
	ip_protocol=6
	port=443
	status=1
}
proto_port={
	ip_protocol=6
	port=1723
	status=0
}
proto_port={
	ip_protocol=6
	port=5060
	status=0
}
proto_port={
	ip_protocol=17
	port=500
	status=1
}
proto_port={
	ip_protocol=17
	port=5060
	status=0
}
proto_port={
	ip_protocol=17
	port=4500
	status=1
}
proto_port={
	ip_protocol=50
	port=0
	status=1
}

wan_metrics={
	link_status=$link_status
	at_capacity=$at_capacity
	dl_speed=$dl_speed
	ul_speed=$ul_speed
	dl_load=$dl_load
	up_load=$up_load
	lmd=$lmd
}
" >> $CONFDIR/hotspot_ap_$interface.conf

	# 3GPP cellular network information
	echo "# 3GPP cellular network information" >> $CONFDIR/hotspot_ap_$interface.conf
	ALLVALUE=`nvram_get 2860 HS_plmn1_mcc`
	getValue "$ALLVALUE" $num
	mcc="$word"
	if [ "$mcc" != "" ]; then
		ALLVALUE=`nvram_get 2860 HS_plmn1_mnc`
		getValue "$ALLVALUE" $num
		mnc="$word"
		create3GPP $mcc $mnc $CONFDIR/hotspot_ap_$interface.conf
	fi
	ALLVALUE=`nvram_get 2860 HS_plmn2_mcc`
	getValue "$ALLVALUE" $num
	mcc="$word"
	if [ "$mcc" != "" ]; then
		ALLVALUE=`nvram_get 2860 HS_plmn2_mnc`
		getValue "$ALLVALUE" $num
		mnc="$word"
		create3GPP $mcc $mnc $CONFDIR/hotspot_ap_$interface.conf
	fi
	ALLVALUE=`nvram_get 2860 HS_plmn3_mcc`
	getValue "$ALLVALUE" $num
	mcc="$word"
	if [ "$mcc" != "" ]; then
		ALLVALUE=`nvram_get 2860 HS_plmn3_mnc`
		getValue "$ALLVALUE" $num
		mnc="$word"
		create3GPP $mcc $mnc $CONFDIR/hotspot_ap_$interface.conf
	fi
	ALLVALUE=`nvram_get 2860 HS_plmn4_mcc`
	getValue "$ALLVALUE" $num
	mcc="$word"
	if [ "$mcc" != "" ]; then
		ALLVALUE=`nvram_get 2860 HS_plmn4_mnc`
		getValue "$ALLVALUE" $num
		mnc="$word"
		create3GPP $mcc $mnc $CONFDIR/hotspot_ap_$interface.conf
	fi
	ALLVALUE=`nvram_get 2860 HS_plmn5_mcc`
	getValue "$ALLVALUE" $num
	mcc="$word"
	if [ "$mcc" != "" ]; then
		ALLVALUE=`nvram_get 2860 HS_plmn5_mnc`
		getValue "$ALLVALUE" $num
		mnc="$word"
		create3GPP $mcc $mnc $CONFDIR/hotspot_ap_$interface.conf
	fi
	ALLVALUE=`nvram_get 2860 HS_plmn6_mcc`
	getValue "$ALLVALUE" $num
	mcc="$word"
	if [ "$mcc" != "" ]; then
		ALLVALUE=`nvram_get 2860 HS_plmn6_mnc`
		getValue "$ALLVALUE" $num
		mnc="$word"
		create3GPP $mcc $mnc $CONFDIR/hotspot_ap_$interface.conf
	fi

	# operating_class=81,115
	ALLVALUE=`nvram_get 2860 HS_operating_class`
	getValue "$ALLVALUE" $num
	operating_class="$word"
	# proxy_arp=1
	ALLVALUE=`nvram_get 2860 HS_proxy_arp`
	getValue "$ALLVALUE" $num
	proxy_arp="$word"
	# dgaf_disabled=0
	ALLVALUE=`nvram_get 2860 HS_dgaf_disabled`
	getValue "$ALLVALUE" $num
	dgaf_disabled="$word"
	# l2_filter=0
	ALLVALUE=`nvram_get 2860 HS_l2_filter`
	getValue "$ALLVALUE" $num
	l2_filter="$word"
	# icmpv4_deny=0
	ALLVALUE=`nvram_get 2860 HS_icmpv4_deny`
	getValue "$ALLVALUE" $num
	icmpv4_deny="$word"

	echo "

# Operating class
operating_class=$operating_class

preferred_candi_list_included=0

abridged=0

disassociation_imminent=0

bss_termination_included=0

ess_disassociation_imminent=1

disassociation_timer=100

validity_interval=0

# BSS Termination Duration
bss_termination_duration=n/a

session_information_url=http://test_url.com

bss_transisition_candi_list_preferences=n/a

timezone=UTC8

# Downstream Group-Aaddressed Forwrding
dgaf_disabled=$dgaf_disabled

proxy_arp=1

# 0: L2FilterDisable
# 1: L2FilterBuiltIn
# 2: L2FilterExternal
l2_filter=$l2_filter

icmpv4_deny=$icmpv4_deny

# p2p management
p2p_cross_connect_permitted=0

mmpdu_size=1024

# 0: server reacheable
# 1: server not reachable for 2F test
# 2: server not reachable for 4F test
external_anqp_server_test=0

# GAS Comeback Delay in TUs
gas_cb_delay=1

hs2_openmode_test=0" >> $CONFDIR/hotspot_ap_$interface.conf

	conf_list="$conf_list""$CONFDIR/hotspot_ap_$interface.conf"
	num=`expr $num + 1`
	if [ $num -lt $BSSIDNUM ]; then
		conf_list="$conf_list;"
	fi
done
if [ "$conf_list" != "" ]; then
	echo "# conf_list
# all configuation files
conf_list=$conf_list" > $CONFDIR/hotspot_ap.conf
	hs -f $CONFDIR/hotspot_ap.conf
fi

