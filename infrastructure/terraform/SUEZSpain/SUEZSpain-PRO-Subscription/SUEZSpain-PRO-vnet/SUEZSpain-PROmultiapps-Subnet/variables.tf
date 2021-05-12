variable "tenant_id" {
    type = string
}

variable "subscription_id" {
    type = string
}

variable "prefix" {
    type = string
    default = "SUEZSpain"
}

variable "environment" {
    type = string
}

variable "project" {
    type = string
    default = "drop"
}

variable "virtual_network_name" {
    type = string
}

variable "vnet_resource_group_name" {
    type = string
}

variable "subnetCIDR" {
    type = string
}