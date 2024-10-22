variable "local-scripts" {
  type = object({
    aws_alb_policy = string 
    eksnodegroup_role = string
  })
}