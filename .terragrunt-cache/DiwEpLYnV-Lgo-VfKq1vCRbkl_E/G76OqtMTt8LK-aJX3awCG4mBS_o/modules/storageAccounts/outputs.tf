output "storage_account_ids" {
    value = {for key, ids in azurerm_storage_account.storageExample : key => ids.id}
}