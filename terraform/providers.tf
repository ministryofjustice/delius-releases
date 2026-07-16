# AWS provider for initial session
provider "aws" {
  alias  = "original-session"
  region = "eu-west-2"
}

# AWS provider for Terraform workspace (every resource will default to using this, unless otherwise specified)
provider "aws" {
  region = "eu-west-2"
  assume_role {
    role_arn = !can(regex("githubactionsrolesession|AdministratorAccess|user", data.aws_caller_identity.original_session.arn)) ? null : can(regex("user", data.aws_caller_identity.original_session.arn)) ? "arn:aws:iam::${local.environment_management.account_ids[terraform.workspace]}:role/${var.collaborator_access}" : "arn:aws:iam::${data.aws_caller_identity.original_session.id}:role/MemberInfrastructureAccess"
  }
}

# AWS provider for the Modernisation Platform
provider "aws" {
  alias  = "modernisation-platform"
  region = "eu-west-2"
  assume_role {
    role_arn = "arn:aws:iam::${local.modernisation_platform_account_id}:role/modernisation-account-limited-read-member-access"
  }
}