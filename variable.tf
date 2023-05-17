variable "location" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
}

variable "environment" {
  type        = string
  description = "The name of the environment in which all resources in this example should be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which all resources in this example should be created."
}

variable "storage_account_primary_access_key" {
  type        = string
  description = "value of the primary access key of the storage account"
}

variable "secret_name" {
  type        = string
  description = "The name of the secret to be created in the key vault"
}