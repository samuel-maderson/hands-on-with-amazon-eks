module "infra_eks" {
    source = "./modules/local-scripts"

    local-scripts = {
        aws_alb_policy = var.main.aws_alb_policy
        eksnodegroup_role = var.main.eksnodegroup_role
        nodegroup_policies = var.main.nodegroup_policies
        dynamodb_table_apis = var.main.dynamodb_table_apis
        deploy_apis = var.main.deploy_apis
    }
}

# This module creates policies && ServiceAccounts for APIs deployments
module "sa_apis" {
  source = "./modules/sa-apis"

  sa-apis = {
    apis_policies = var.sa-apis.apis_policies
  }
}