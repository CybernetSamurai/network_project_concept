################################################################################
#            MikroTik Configuration for "Student 4" Network                    #
#                                                                              #
#            Network:  40.0.0.0/24                                             #
#            Internal: 40.0.0.1                                                #
#            External: 50.0.0.4                                                #
#                                                                              #
################################################################################

# set hostname
/system/identity
set name=Student4-Gateway

# set interface addresses
/ip/address
add interface=ether1 address=50.0.0.4/24
add interface=ether2 address=40.0.0.1/24

# remove default dhcp client (uses static IP)
/ip/dhcp-client
remove [find]

############################### DHCP Relay Config ##############################

/ip/dhcp-relay
add name=STDNT_4_RELAY interface=ether2 dhcp-server=50.0.0.1 local-address=40.0.0.1 disabled=no

########################## Route Distribution Config ###########################

/routing/rip/instance
add name=STDNT_4_RIP redistribute=connected

/routing/rip/interface-template
add interfaces=ether1 instance=STDNT_4_RIP
