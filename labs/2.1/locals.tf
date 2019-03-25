locals {
  project_name      = "workshop"
  azure_region      = "West Europe"
  environment       = "TEST"
  environment_lower = lower(local.environment)

  common_tags = {
    Environment = local.environment_lower
    Scope       = lower(local.project_name)
  }
}
