locals {
    account_prefix = "delius-core"

    env_name = "${local.account_prefix}-${var.short_environment_name}"

    modernisation_platform_account_id = data.aws_ssm_parameter.modernisation_platform_account_id.value

    environment_management = jsondecode(data.aws_secretsmanager_secret_version.environment_management.secret_string)

    tags = merge(
      jsondecode(data.http.environments_file.response_body).tags,
      { "is-production" = var.is_production },
      { "environment-name" = local.env_name },
      { "source-code" = "https://github.com/ministryofjustice/delius-releases" }
    )
}