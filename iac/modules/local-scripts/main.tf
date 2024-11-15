resource "null_resource" "install_acm_certificate" {
    provisioner "local-exec" {
      command = "cd Infrastructure/cloudformation/ssl-certificate && ./create.sh"
    }
}

resource "null_resource" "install_aws_load_balancer" {
    provisioner "local-exec" {
      command = "cd Infrastructure/k8s-tooling/load-balancer-controller && ./create.sh"
    }
}

resource "null_resource" "deploy_application" {
  provisioner "local-exec" {
    command = "cd Infrastructure/k8s-tooling/load-balancer-controller/test/ && ./run.sh"
  }

  depends_on = [ null_resource.install_aws_load_balancer ]
}

resource "null_resource" "install_external_dns" {
  provisioner "local-exec" {
    command = "cd Infrastructure/k8s-tooling/external-dns/ && ./create.sh"
  }
}

resource "null_resource" "helm_add_app_dns" {
  provisioner "local-exec" {
    command = "cd Infrastructure/k8s-tooling/load-balancer-controller/test/ && ./run-with-ssl.sh"
  }
}


resource "aws_iam_role_policy_attachment" "nodegroup_role" {
  role       = data.aws_iam_role.nodegroup.name
  policy_arn = data.aws_iam_policy.alb_policy.arn
}

resource "aws_iam_role_policy_attachment" "nodegroup_policies" {
  for_each = toset(var.local-scripts.nodegroup_policies)
  role       = data.aws_iam_role.nodegroup.name
  policy_arn = each.value
}

resource "null_resource" "dynamodb_table_apis" {
  for_each = toset(var.local-scripts.dynamodb_table_apis)
  provisioner "local-exec" {
    command = each.value
  }
}

resource "null_resource" "deploy_apis" {
  for_each = toset(var.local-scripts.deploy_apis)

  provisioner "local-exec" {
    command = each.value
  }
}