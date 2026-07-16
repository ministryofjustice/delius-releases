locals {
  versions = jsondecode(file("../ndelius_versions.json"))
}

module "container_definition" {
  for_each = var.services

  source                   = "git::https://github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster//container?ref=v5.0.0"
  name                     = each.key
  image                    = "${local.environment_management.account_ids["core-shared-services-production"]}.dkr.ecr.eu-west-2.amazonaws.com/delius-core-weblogic:${local.versions[var.short_environment_name][each.key].image_tag}"
  memory                   = each.value.container_memory
  cpu                      = each.value.container_cpu
  essential                = true
  readonly_root_filesystem = false

  environment = [
    for k, v in var.weblogic_params : {
      name  = k
      value = v
    }
  ]

  secrets = local.secrets_map

  port_mappings = [
    {
      containerPort = each.value.container_port
      protocol      = "tcp"
    }
  ]

  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group"         = "${local.env_name}-${each.key}"
      "awslogs-region"        = "${data.aws_region.current.region}"
      "awslogs-stream-prefix" = "${local.env_name}-${each.key}"
    }
  }
}

module "ecs_service" {
  for_each = var.services

  source                = "git::https://github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster//service?ref=v6.0.2"
  container_definitions = nonsensitive(module.container_definition[each.key].json_encoded_list)
  cluster_arn           = data.aws_ecs_cluster.ecs.arn
  name                  = "${local.env_name}-${each.key}"

  task_cpu    = each.value.container_cpu
  task_memory = each.value.container_memory

  pin_task_definition_revision = each.value.task_definition_revision

  force_new_deployment               = false
  capacity_provider                  = "${each.key}-${var.short_environment_name}-cp"
  desired_count                      = each.value.task_count
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

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

  enable_execute_command = true

  tags = local.tags
}
