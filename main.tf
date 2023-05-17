data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = format("kvexampledemo%s%s", var.location, var.environment)
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"
}


resource "azurerm_key_vault_access_policy" "kv_access_policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "Delete",
    "Purge",
    "List"
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Purge"
  ]

  storage_permissions = [
    "Get",
    "List"
  ]
}

resource "azurerm_key_vault_secret" "kv_secret" {
  name         = format("kv-secret%s%s", var.location, var.environment)
  value        = var.storage_account_primary_access_key
  key_vault_id = azurerm_key_vault.kv.id
  depends_on   = [azurerm_key_vault_access_policy.kv_access_policy]
}