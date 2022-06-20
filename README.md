# VPC VPN Gateway Module

Create a VPC VPN Gateway on a subnet within a VPC with any number of connections.

---

## Module Variables

Name                                | Type                                                        | Description                                                                                                       | Sensitive | Default
----------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | --------- | ---------------------------------------------
prefix                              | string                                                      | The prefix that you would like to append to your resources                                                        |           | 
region                              | string                                                      | The region where the VPC is deployed                                                                            |           | 
resource_group_id                   | string                                                      | ID of the resource group where gateway will be provisioned                                                        |           | null
tags                                | list(string)                                                | List of Tags for the resource created                                                                             |           | null
vpc_id                              | string                                                      | ID of the VPC where gateway will be created                                                                       |           | 
subnet_id                           | string                                                      | ID of the Subnet within the VPC where the gateway will be created |  | 

---

## VPN Gateway Variable

```terraform
variable "vpn_gateway" {
  description = "VPN Gateways to create."
  type = object({
    use_vpn_gateway = bool             # create vpn gateway
    name            = optional(string) # gateway name
    mode            = optional(string) # Can be `route` or `policy`. Default is `route`
    connections = list(
      object({
        peer_address   = string
        preshared_key  = string
        local_cidrs    = optional(list(string))
        peer_cidrs     = optional(list(string))
        admin_state_up = optional(bool)
      })
    )
  })
```

---

## Example Usage

```terraform
module "vpn_gateway" {
  source            = "github.com/Cloud-Schematics/vpc-vpn-gateway-module"
  prefix            = var.prefix
  resource_group_id = data.ibm_resource_group.resource_group.id
  tags              = var.tags
  vpc_id            = ibm_is_vpc.vpc.id
  subnet_id         = module.gateway_subnets.subnets[0].id
  vpn_gateway       = var.vpn_gateway
}
```