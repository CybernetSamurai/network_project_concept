################################################################################
#            MikroTik Configuration for "Student 2" Network                    #
#                                                                              #
#            Network:  20.0.0.0/24                                             #
#            Internal: 20.0.0.1                                                #
#            External: 50.0.0.2                                                #
#                                                                              #
################################################################################

# set hostname
/system/identity
set name=Student2-Gateway

# set interface addresses
/ip/address
add interface=ether1 address=50.0.0.2/24
add interface=ether2 address=20.0.0.1/24

# remove default dhcp client (uses static IP)
/ip/dhcp-client
remove [find]

############################### DHCP Relay Config ##############################

/ip/dhcp-relay
add name=STDNT_2_RELAY interface=ether2 dhcp-server=50.0.0.1 local-address=20.0.0.1 disabled=no

########################## Route Distribution Config ###########################

/routing/rip/instance
add name=STDNT_2_RIP redistribute=connected

/routing/rip/interface-template
add interfaces=ether1 instance=STDNT_2_RIP
