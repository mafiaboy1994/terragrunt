terraform {
  source = "../modules/network"
}

dependency "root" {
  config_path  = "../"
  skip_outputs = false
}


# locals {
#   module_spoke_networking = dependency.root.outputs.module_spoke_networks
# }


inputs = {
  spoke_networking = dependency.root.outputs.module_spoke_networks
}

# inputs = {
#   spoke_networking = {
#     primary = {
#       virtual_network_name = "test-vnet-02"
#       location             = "uksouth"
#       vnet_address_space   = "10.0.0.0/16"
#       rg_name              = "test-rg-02"
#       subnets = {
#         subnet1 = {
#           address_prefix = "10.0.1.0/24"
#           name           = "snet-test"
#           nsgs = {
#             name = "test-nsg"
#           }
#         }
#         subnet2 = {
#           address_prefix = "10.0.2.0/24"
#           name           = "snet-test-02"
#           nsgs = {
#             name = "test-02-nsg"
#           }
#         }
#       }
#     }
#   }
#}
