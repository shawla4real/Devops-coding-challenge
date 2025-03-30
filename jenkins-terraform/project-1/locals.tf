locals {
  prefix = var.prefix
  common_tags = {
    Environment = var.environment
    Contact     = var.contact
    Managed_by  = "Terraform"
  }
}