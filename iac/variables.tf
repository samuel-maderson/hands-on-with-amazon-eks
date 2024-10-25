variable "main" {
  type = object({
    aws_alb_policy = string 
    eksnodegroup_role = string
    nodegroup_policies = list(string)
    deploy_apis = list(string)
  })
}