terraform {
  backend "s3" {
    encrypt              = true
    key                  = "terraform.tfstate"
    region               = "eu-west-2"
    use_lockfile         = true
    workspace_key_prefix = "weblogic-ecs" # This will store the object as weblogic-ecs/${workspace}/terraform.tfstate
  }
}