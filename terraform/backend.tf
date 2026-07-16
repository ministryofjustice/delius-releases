# terraform {
#   backend "s3" {
#     encrypt = true
#     key     = "terraform.tfstate"
#     region  = "eu-west-2"
#     bucket  = "modernisation-platform-terraform-state"
#   }
# }

terraform {
  # `backend` blocks do not support variables, so the following are hard-coded here:
  # - S3 bucket name, which is created in modernisation-platform-account/s3.tf
  backend "s3" {
    encrypt              = true
    key                  = "terraform.tfstate"
    region               = "eu-west-2"
    use_lockfile         = true
    workspace_key_prefix = "weblogic-ecs" # This will store the object as weblogic-ecs/${workspace}/terraform.tfstate
  }
}