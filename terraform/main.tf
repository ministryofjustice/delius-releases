locals {
  image_tags = merge(
    {
      weblogic     = var.weblogic_image_tag
      weblogic-eis = var.weblogic_eis_image_tag
    },
    var.short_environment_name == "test" ? { weblogic-data = "5.8.12.6-testdata-api" } : {}
  )

  weblogic_data_excluded_params = [
    "API_CLIENT_ID",
    "API_CLIENT_SECRET",
    "APPLICATIONINSIGHTS_CONNECTION_STRING",
    "BREACH_NOTICE_API_URL",
    "BREACH_NOTICE_UI_URL_FORMAT",
    "COSSO_API_URL",
    "COSSO_UI_URL_FORMAT",
    "DEEPLINK_BASE_URL",
    "JDBC_CONNECTION_POOL_MAX_CAPACITY",
    "JDBC_CONNECTION_POOL_MIN_CAPACITY",
    "NOTIFICATION_API_KEY",
    "OAUTH_CALLBACK_URL",
    "OAUTH_CLIENT_ID",
    "OAUTH_CLIENT_SECRET",
    "OAUTH_DEFAULT_SCOPE",
    "OAUTH_LOGIN_ENABLED",
    "OAUTH_LOGIN_NAME",
    "OAUTH_TOKEN_VERIFICATION_URL",
    "OAUTH_URL",
    "OFFENDER_SEARCH_API_URL",
    "OS_DATAHUB_API_KEY",
    "PREPARE_CASE_FOR_SENTENCE_URL",
    "PSR_SERVICE_URL",
    "PSR_UI_URL_FORMAT",
    "SUICIDE_RISK_API_URL",
    "SUICIDE_RISK_UI_URL_FORMAT",
    "TRAINING_MODE_APP_NAME"
  ]

  weblogic_data_params = {
    for k, v in var.weblogic_params :
    k => v
    if !contains(local.weblogic_data_excluded_params, k)
  }
}

module "container_definition" {
  for_each = var.services

  source                   = "git::https://github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster//container?ref=v6.1.0"
  name                     = each.key
  image                    = "374269020027.dkr.ecr.eu-west-2.amazonaws.com/delius-core-weblogic:${local.image_tags[each.key]}"
  memory                   = each.value.container_memory
  cpu                      = each.value.container_cpu
  essential                = true
  readonly_root_filesystem = false
  container_user           = "root"

  environment = [
    for k, v in ( each.key == "weblogic-data" ? local.weblogic_data_params : var.weblogic_params ) :
    {
      name  = k
      value = v
    }
  ]

  secrets = ( each.key == "weblogic-data" ? local.weblogic_data_secrets : local.secrets_map )

  port_mappings = [
    {
      containerPort = each.value.container_port
      protocol      = "tcp"
    }
  ]

  mount_points = [{
    sourceVolume  = "access_log"
    containerPath = "/u01/domains/NDelius/servers/AdminServer/logs"
    readOnly      = false
  }]

  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-create-group"  = "true"
      "awslogs-group"         = "${local.env_name}-${each.key}"
      "awslogs-region"        = "${data.aws_region.current.region}"
      "awslogs-stream-prefix" = "${local.env_name}-${each.key}"
    }
  }
}

module "access_logs" {
  for_each = var.services

  source                   = "git::https://github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster//container?ref=v6.1.0"
  name                     = "access_log"
  image                    = "public.ecr.aws/amazonlinux/amazonlinux:2"
  cpu                      = 0
  essential                = true
  environment              = []
  secrets                  = []
  port_mappings            = []
  readonly_root_filesystem = false
  container_user           = "root"

  command = [
    "/bin/sh",
    "-c",
    "while [ ! -f '/u01/domains/NDelius/servers/AdminServer/logs/access.log' ]; do sleep 1; done && tail -n+1 -F '/u01/domains/NDelius/servers/AdminServer/logs/access.log'"
  ]

  mount_points = [{
    sourceVolume  = "access_log"
    containerPath = "/u01/domains/NDelius/servers/AdminServer/logs"
    readOnly      = true
  }]

  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-create-group"  = "true"
      "awslogs-group"         = "${local.env_name}-${each.key}-access-logs"
      "awslogs-region"        = "${data.aws_region.current.region}"
      "awslogs-stream-prefix" = "${local.env_name}-${each.key}"
    }
  }

  container_dependencies = [{
    containerName = each.key
    condition     = "START"
  }]
}

module "ecs_service" {
  for_each = var.services

  source      = "git::https://github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster//service?ref=v6.0.2"
  name        = "${var.short_environment_name}-${each.key}"
  cluster_arn = data.aws_ecs_cluster.ecs.arn

  container_definitions = jsonencode(concat(
    jsondecode(nonsensitive(module.container_definition[each.key].json_encoded_list)),
    jsondecode(nonsensitive(module.access_logs[each.key].json_encoded_list))
  ))

  task_cpu    = each.value.container_cpu
  task_memory = each.value.container_memory

  force_new_deployment               = false
  capacity_provider                  = "${each.key}-${var.short_environment_name}-ec2-cp"
  desired_count                      = each.value.task_count
  deployment_minimum_healthy_percent = each.value.deployment_minimum_healthy_percent
  deployment_maximum_percent         = each.value.deployment_maximum_percent

  service_role_arn   = data.aws_iam_role.ecs_service[each.key].arn
  task_role_arn      = data.aws_iam_role.ecs_task[each.key].arn
  task_exec_role_arn = data.aws_iam_role.ecs_task_exec[each.key].arn

  health_check_grace_period_seconds = each.value.grace_period_seconds

  service_load_balancers = [
    {
      target_group_arn = data.aws_lb_target_group.alb[each.key].arn
      container_name   = each.key
      container_port   = each.value.container_port
    },
    {
      target_group_arn = data.aws_lb_target_group.nlb[each.key].arn
      container_name   = each.key
      container_port   = each.value.container_port
    }
  ]

  security_groups = [data.aws_security_group.ecs_service[each.key].id, data.aws_security_group.ecs_cluster[each.key].id]

  subnets = [
    data.aws_subnet.private_subnets_a.id,
    data.aws_subnet.private_subnets_b.id,
    data.aws_subnet.private_subnets_c.id
  ]

  efs_volumes = [{
    name      = "access_log"
    host_path = null

    efs_volume_configuration = []
  }]

  enable_execute_command = true

  tags = local.tags
}
