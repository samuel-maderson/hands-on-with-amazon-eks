data "aws_iam_role" "nodegroup" {
  name = var.local-scripts.eksnodegroup_role
}

data "aws_iam_policy" "alb_policy" {
  arn = var.local-scripts.aws_alb_policy
}