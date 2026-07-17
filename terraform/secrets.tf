# Secrets must be manually configured
locals {
  secrets_list = [
    "ADMIN_PASSWORD",
    "ANALYTICS_TAG",
    "API_CLIENT_SECRET",
    "APPLICATIONINSIGHTS_CONNECTION_STRING",
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
    "JDBC_PASSWORD",
    "LDAP_CREDENTIAL",
    "MERGE_SECRET",
    "NOTIFICATION_API_KEY",
    "OAUTH_CLIENT_SECRET",
    "PDFCREATION_SECRET",
    "TOPIC_ARN",
    "USERMANAGEMENT_SECRET"
  ]

	secrets_map = [
		for key, parameter in aws_ssm_parameter.secure : {
			name      = key
			valueFrom = parameter.arn
		}
	]	
}

resource "aws_ssm_parameter" "secure" {
  for_each = toset(local.secrets_list)
  name     = "/${local.env_name}/weblogic/${each.value}"
  type     = "SecureString"
  value    = "change_me"
  lifecycle {
    ignore_changes = [value]
  }
}