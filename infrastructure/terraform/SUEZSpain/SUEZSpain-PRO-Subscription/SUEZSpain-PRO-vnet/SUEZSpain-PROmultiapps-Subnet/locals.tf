locals {
  subnetName      = "${var.prefix}-${upper(var.environment)}${upper(var.project)}-SUBNET"
}