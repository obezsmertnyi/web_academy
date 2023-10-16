output "gitlab_url" {
  value = var.gitlab_url
  
}

output "gitlab_group" {
  value = gitlab_group.ob_gitlab_group.description
  sensitive = false

}

output "gitlab_project" {
  value = [gitlab_project.this_app.description, gitlab_project.this_infra.description]
  sensitive = false

}



