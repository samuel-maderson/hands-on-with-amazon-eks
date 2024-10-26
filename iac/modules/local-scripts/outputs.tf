output "nodegroup_role_name" {
  value = data.aws_iam_role.nodegroup.name
}

output "nodegroup_role_arn" {
  value = data.aws_iam_role.nodegroup.arn
}
