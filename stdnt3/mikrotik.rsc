################################################################################
#            MikroTik Configuration for "Student 3" Network                    #
#                                                                              #
#            Network:  30.0.0.0/24                                             #
#            Internal: 30.0.0.1                                                #
#            External: 50.0.0.3                                                #
#                                                                              #
################################################################################

# set hostname
/system/identity
set name=Student3-Gateway

# set interface addresses
/ip/address
add interface=ether1 address=50.0.0.3/24
add interface=ether2 address=30.0.0.1/24

# remove default dhcp client (uses static IP)
/ip/dhcp-client
remove [find]

############################### DHCP Relay Config ##############################

/ip/dhcp-relay
add name=STDNT_3_RELAY interface=ether2 dhcp-server=50.0.0.1 local-address=30.0.0.1 disabled=no

########################## Route Distribution Config ###########################

/routing/rip/instance
add name=STDNT_3_RIP redistribute=connected

/routing/rip/interface-template
add interfaces=ether1 instance=STDNT_3_RIP
