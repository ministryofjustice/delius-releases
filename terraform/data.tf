data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_subnet" "private_subnets_a" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = "hmpps-${var.long_environment_name}-general-private-${data.aws_region.current.region}a"
  }
}

data "aws_subnet" "private_subnets_b" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = "hmpps-${var.long_environment_name}-general-private-${data.aws_region.current.region}b"
  }
}

data "aws_subnet" "private_subnets_c" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = "hmpps-${var.long_environment_name}-general-private-${data.aws_region.current.region}c"
  }
}

data "aws_ecs_cluster" "ecs" {
  cluster_name = "${local.account_prefix}-${var.short_environment_name}-cluster"
}

locals {
  target_group_names = {
    weblogic     = var.weblogic_tg_name
    weblogic-eis = var.weblogic_eis_tg_name
  }
}

data "aws_lb_target_group" "alb" {
  for_each = local.target_group_names
  name     = each.value
}

data "aws_lb_target_group" "nlb" {
  for_each = var.services
  name     = "${each.key}-${var.short_environment_name}-at-8080"
}

data "aws_iam_role" "ecs_service" {
  for_each = var.services
  name     = "${var.short_environment_name}-${each.key}-ecs-service"
}

data "aws_iam_role" "ecs_task" {
  for_each = var.services
  name     = "${var.short_environment_name}-${each.key}-ecs-task"
}

data "aws_iam_role" "ecs_task_exec" {
  for_each = var.services
  name     = "${var.short_environment_name}-${each.key}-ecs-task-exec"
}

data "aws_security_group" "ecs_service" {
  for_each = var.services
  name     = "ecs-service-${each.key}-${var.short_environment_name}"
}

data "aws_security_group" "ecs_cluster" {
  for_each = var.services
  filter {
    name   = "group-name"
    values = ["ecs-cluster-${var.short_environment_name}*"]
  }
}

# Get the environments file from the main repository
data "http" "environments_file" {
  url = "https://raw.githubusercontent.com/ministryofjustice/modernisation-platform/main/environments/delius-core.json"
}

# Get modernisation account id from ssm parameter
data "aws_ssm_parameter" "modernisation_platform_account_id" {
  name     = "modernisation_platform_account_id"
}
