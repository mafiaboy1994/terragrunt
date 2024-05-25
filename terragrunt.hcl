# terraform {
#   source = "./spoke_networking"
# }

terraform {
  source = "./"
}

inputs = {

}


# dependency "root_module" {
#   config_path  = "."
#   skip_outputs = false
# }

# inputs = {
#   spoke_networking = "${output.module_spoke_networks}"
# }
