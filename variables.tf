variable "project_id" {
  description = "The ID of the project where this project will run within"
}
variable "target_project_id" {
  description = "The ID of the project where this project will target"
}
variable "lock_timeout" {
  description = "How long terraform should wait to get a lock before timing out (in seconds)"
  default = 600
}
variable "target_credentials" {
  description = "The location of the credentials file for the target project's service account"
}

variable "repository" {
  description = "The name of the repository for the target source code"
}