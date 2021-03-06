# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

dependencies {
  paths = ["../s3/organiser-ui", "../s3/assets", "../s3/pwa-ui"]
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::git@github.com:mjedrasz/ttd_terraform.git//cloudfront?ref=v0.0.1"
}

# Include all settings from the root terraform.tfvars file
include {
  path = "${find_in_parent_folders()}"
}


# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  organiser_aliases = ["test-organiser-ui.ttd.pl"]
  assets_aliases    = ["test-assets.ttd.pl"]
  pwa_aliases       = ["test-pwa-ui.ttd.pl"]
  domain            = "ttd.pl"
}
