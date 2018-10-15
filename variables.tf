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

