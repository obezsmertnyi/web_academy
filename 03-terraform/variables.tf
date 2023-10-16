# Gitlab cred
variable "gitlab_url" {
  description = "Gitlab Main URL"
  type        = string
  default     = "http://minio.bol-v.com/api/v4/"

}
variable "gitlab_token" {
  description = "Main provider Gitlab Access Token"
  type        = string

}

# Gitlab provision vars
variable "test_group_number" {
  description = "Onboarding group number"
  type        = number
  default     = 1410

}
