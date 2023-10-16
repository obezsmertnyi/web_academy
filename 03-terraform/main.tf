# Backend for tfstate
terraform {
  backend "s3" {
    bucket = "backend-tfstate"
    key    = "global/terraform.tfstate"
    region = "main"
    endpoints = {
      s3 = "http://minio.bol-v.com:9000"
    }
    shared_credentials_files = ["./.terraform/.credentials_minio"]
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
    encrypt                     = true
  }
}

# Provider configuration
provider "gitlab" {
  # Configuration options
  base_url = var.gitlab_url
  token    = var.gitlab_token
}

# locals
locals {
  name_prefix = "test-${var.test_group_number}"
}

# Create a project in the example group
resource "gitlab_group" "ob_gitlab_group" {
  name        = local.name_prefix
  path        = local.name_prefix
  description = "An ${local.name_prefix} group"

}

# Create a project in the example group
resource "gitlab_project" "this_app" {
  name                   = "${upper(local.name_prefix)}-app project"
  description            = "${upper(local.name_prefix)}-app project"
  namespace_id           = gitlab_group.ob_gitlab_group.id
  initialize_with_readme = true
}

resource "gitlab_project" "this_infra" {
  name                   = "${upper(local.name_prefix)}-infra project"
  description            = "${upper(local.name_prefix)}-infra project"
  namespace_id           = gitlab_group.ob_gitlab_group.id
  initialize_with_readme = true
}
