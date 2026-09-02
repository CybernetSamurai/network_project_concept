################################################################################
#            MikroTik Configuration for "Student 1" Network                    #
#                                                                              #
#            Network:  10.0.0.0/24                                             #
#            Internal: 10.0.0.1                                                #
#            External: 50.0.0.1                                                #
#                                                                              #
#            Provides DHCP services for each student network.                  #
################################################################################

# set hostname
/system/identity
set name=Student1-Gateway

# set interface addresses
/ip/address
add interface=ether1 address=50.0.0.1/24
add interface=ether2 address=10.0.0.1/24

# remove default dhcp client (uses static IP)
/ip/dhcp-client
remove [find]

############################## DHCP Server Config ##############################

# configure address ranges for each subnet
/ip/pool
add name=STDNT_1 ranges=10.0.0.100-10.0.0.200
add name=STDNT_2 ranges=20.0.0.100-20.0.0.200
add name=STDNT_3 ranges=30.0.0.100-30.0.0.200
add name=STDNT_4 ranges=40.0.0.100-40.0.0.200

# configure dhcp servers
# "relay" param refers to internal IP of relay forwarding discovery
/ip/dhcp-server
add name=STDNT_1_DHCP interface=ether2 address-pool=STDNT_1
add name=STDNT_2_DHCP interface=ether1 address-pool=STDNT_2 relay=20.0.0.1
add name=STDNT_3_DHCP interface=ether1 address-pool=STDNT_3 relay=30.0.0.1
add name=STDNT_4_DHCP interface=ether1 address-pool=STDNT_4 relay=40.0.0.1

# set dhcp options
/ip/dhcp-server/network
add address=10.0.0.0/24 gateway=10.0.0.1 dns-server=20.0.0.2 domain=stdnt1.net
add address=20.0.0.0/24 gateway=20.0.0.1 dns-server=20.0.0.2 domain=stdnt2.net
add address=30.0.0.0/24 gateway=30.0.0.1 dns-server=20.0.0.2 domain=stdnt3.net
add address=40.0.0.0/24 gateway=40.0.0.1 dns-server=20.0.0.2 domain=stdnt4.net

########################## Route Distribution Config ###########################

/routing/rip/instance
add name=STDNT_1_RIP redistribute=connected

/routing/rip/interface-template
add interfaces=ether1 instance=STDNT_1_RIP
