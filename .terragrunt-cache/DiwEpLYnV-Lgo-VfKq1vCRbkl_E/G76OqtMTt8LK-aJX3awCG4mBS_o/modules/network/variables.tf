variable "spoke_networking" {
      type = map(object({
        virtual_network_name = string
        location             = string
        vnet_address_space   = string
        rg_name              = string
        subnets               = optional(map(object({
          address_prefix = string
          name           = string
          nsgs = optional(object({
            name = string
          }))
        })))
    }))
 }
