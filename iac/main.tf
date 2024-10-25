module "infra_eks" {
    source = "./modules/local-scripts"

    local-scripts = {
        aws_alb_policy = var.main.aws_alb_policy
        eksnodegroup_role = var.main.eksnodegroup_role
        nodegroup_policies = var.main.nodegroup_policies
        deploy_apis = var.main.deploy_apis
    }
}