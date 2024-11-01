module "infra_eks" {
    source = "./modules/local-scripts"

    local-scripts = {
        aws_alb_policy = var.main.aws_alb_policy
        eksnodegroup_role = var.main.eksnodegroup_role
        nodegroup_policies = var.main.nodegroup_policies
        dynamodb_table_apis = var.main.dynamodb_table_apis
        deploy_apis = var.main.deploy_apis
        deploy_apis_sa_policy = var.main.deploy_apis_sa_policy
    }
}