variable "storageAccounts" {
            type = map(object({
                sa_name = string
                account_tier = string
                account_replication_type = string
                resource_group_name = string
                location = string
            
            }))
        }