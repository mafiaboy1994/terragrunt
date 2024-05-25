locals {
  const_yaml = "yaml"
  const_yml  = "yml"

  config_file_name      = var.configuration_file_path == "" ? "config.yaml" : basename(var.configuration_file_path)
  config_file_split     = split(".", local.config_file_name)
  config_file_extension = replace(lower(element(local.config_file_split, length(local.config_file_split) - 1)), local.const_yml, local.const_yaml)
}
locals {
  config_template_file_variables = {
    default_location = var.default_location
    default_postfix  = var.default_postfix
    # root_parent_management_group_id = var.root_parent_management_group_id == "" ? data.azurerm_client_config.core.tenant_id : var.root_parent_management_group_id
    # subscription_id_connectivity    = var.subscription_id_connectivity
    # subscription_id_identity        = var.subscription_id_identity
    # subscription_id_management      = var.subscription_id_management
  }

  config = (local.config_file_extension == local.const_yaml ?
    yamldecode(templatefile("${path.module}/${local.config_file_name}", local.config_template_file_variables)) :
    jsondecode(templatefile("${path.module}/${local.config_file_name}", local.config_template_file_variables))
  )
}
locals {
  archetypes = try(merge(local.config.archetypes, {}), {})
}
locals {

  module_spoke_networks = {
    for key, spoke in local.config.connectivity.spoke_networking : key => {
      virtual_network_name = spoke.virtual_network_name
      location             = spoke.location
      vnet_address_space   = spoke.vnet_address_space
      rg_name              = spoke.rg_name
      subnets              = spoke.subnets
    }
  }


}
