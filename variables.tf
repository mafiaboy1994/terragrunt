variable "default_location" {
  description = "The location for Azure resources. (e.g 'uksouth')|1|azure_location"
  type        = string
}

variable "default_postfix" {
  description = "The default postfix for Azure resources. (e.g 'landing-zone')|2|azure_name"
  type        = string
  default     = "landing-zone"
}

variable "configuration_file_path" {
  description = "The path of the configuration file|7|configuration_file_path"
  type        = string
  default     = ""
}


variable "subscription_id" {
  type = string
}
