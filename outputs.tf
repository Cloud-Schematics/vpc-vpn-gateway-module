##############################################################################
# VPN Gateway Outputs
##############################################################################

output vpn_gateway {
    description = "VPN Gateway information"
    value       = ibm_is_vpn_gateway.gateway[0]
}

##############################################################################