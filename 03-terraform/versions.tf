terraform {
  required_version = ">1.5.7"
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "16.4.1"
    }
  }
}