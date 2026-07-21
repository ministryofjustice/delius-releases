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

variable "long_environment_name" {
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
    container_port           = number
    container_memory         = number
    container_cpu            = number
    task_count               = number
		grace_period_seconds		 = number
  }))
}

variable "weblogic_params" {
  type = object({
    API_CLIENT_ID                      = string
    AWS_REGION                         = string
    BREACH_NOTICE_API_URL              = string
    BREACH_NOTICE_UI_URL_FORMAT        = string
    COOKIE_SECURE                      = string
    DMS_HOST                           = string
    DMS_OFFICE_URI_HOST                = string
    DMS_OFFICE_URI_PORT                = string
    DMS_PORT                           = string
    DMS_PROTOCOL                       = string
    EIS_USER_CONTEXT                   = string
    ELASTICSEARCH_URL                  = string
    GDPR_URL                           = string
    JDBC_CONNECTION_POOL_MAX_CAPACITY  = string
    JDBC_CONNECTION_POOL_MIN_CAPACITY  = string
    JDBC_URL                           = string
    JDBC_USERNAME                      = string
    LDAP_HOST                          = string
    LDAP_PRINCIPAL                     = string
    LOG_LEVEL_NDELIUS                  = string
    MERGE_API_URL                      = string
    MERGE_OAUTH_URL                    = string
    MERGE_URL                          = string
    NDELIUS_CLIENT_ID                  = string
    OAUTH_CALLBACK_URL                 = string
    OAUTH_CLIENT_ID                    = string
    OAUTH_DEFAULT_SCOPE                = string
    OAUTH_LOGIN_ENABLED                = string
    OAUTH_LOGIN_NAME                   = string
    OAUTH_TOKEN_VERIFICATION_URL       = string
    OAUTH_URL                          = string
    OFFENDER_SEARCH_API_URL            = string
    PASSWORD_RESET_URL                 = string
    PDFCREATION_TEMPLATES              = string
    PDFCREATION_URL                    = string
    PREPARE_CASE_FOR_SENTENCE_URL      = string
    PSR_SERVICE_URL                    = string
    TRAINING_MODE_APP_NAME             = string
    TZ                                 = string
    USERMANAGEMENT_URL                 = string
    USER_CONTEXT                       = string
    USER_MEM_ARGS                      = string
  })
}