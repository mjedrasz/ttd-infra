# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::git@github.com:mjedrasz/ttd_terraform.git//dynamodb?ref=v0.0.1"
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
  override_dynamodb_endpoint = ""
  table_name                 = "one-table"
  read_capacity              = 12
  write_capacity             = 12
  range_key                  = "sk"
  hash_key                   = "id"
  attributes = [{ name = "id", type = "S" },
    { name = "sk", type = "S" },
    { name = "gsi1sk", type = "S" }]
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"
  gsi = [{ name = "gsi-1", read_capacity = 12, write_capacity = 12, hash_key = "sk", range_key = "gsi1sk", projection_type = "ALL", non_key_attributes = [] }]
  lsi = []
}