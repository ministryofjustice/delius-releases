variable "collaborator_access" {
  type        = string
  default     = "developer"
  description = "Collaborators must specify which access level they are using, eg set an environment variable of export TF_VAR_collaborator_access=migration"
}

variable "weblogic_image_tag" {
  type        = string
  description = "The image tag for the Weblogic container"
}

variable "weblogic_eis_image_tag" {
  type        = string
  description = "The image tag for the Weblogic EIS container"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the ECS cluster is deployed"
}

variable "account_name" {
  type        = string
  description = "The long name of the environment, e.g. development"
}

variable "short_environment_name" {
  type        = string
  description = "The short name of the environment, e.g. dev"
}

variable "is_production" {
  type        = bool
  description = "Whether this is a production environment"
}

variable "weblogic_tg_name" {
  type        = string
  description = "The name of the weblogic frontend alb target group"
}

variable "weblogic_eis_tg_name" {
  type        = string
  description = "The name of the weblogic_eis frontend alb target group"
}

variable "services" {
  type = map(object({
    container_port                     = number
    container_memory                   = number
    container_cpu                      = number
    task_count                         = number
    grace_period_seconds               = number
    deployment_minimum_healthy_percent = optional(number, 0)
    deployment_maximum_percent         = optional(number, 100)
  }))
}

variable "weblogic_params" {
  type        = map(string)
  description = "List of parameters"
}
