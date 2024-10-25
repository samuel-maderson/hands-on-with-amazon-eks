resource "null_resource" "prepare_cloud_shell" {
    provisioner "local-exec" {
        command = "../scripts-by-chapter/prepare-cloud-shell.sh"

    }
}

resource "null_resource" "create_eks_cluster" {
    provisioner "local-exec" {
      command = "../scripts-by-chapter/chapter-1.sh"
    }

    depends_on = [ null_resource.prepare_cloud_shell ]
}

resource "null_resource" "install_aws_load_balancer" {
    provisioner "local-exec" {
      command = "cd Infrastructure/k8s-tooling/load-balancer-controller && ./create.sh ${var.local-scripts.eksnodegroup_role} ${var.local-scripts.aws_alb_policy}"
    }

    depends_on = [ null_resource.create_eks_cluster ]
}

resource "null_resource" "deploy_application" {
  provisioner "local-exec" {
    command = "cd Infrastructure/k8s-tooling/load-balancer-controller/test/ && ./run.sh"
  }
}

resource "null_resource" "install_external_dns" {
  provisioner "local-exec" {
    command = "Infrastructure/k8s-tooling/external-dns/create.sh"
  }
}

resource "null_resource" "helm_add_app_dns" {
  provisioner "local-exec" {
    command = "cd Infrastructure/k8s-tooling/load-balancer-controller/test/ && ./run-with-ssl.sh"
  }
}


# resource "aws_iam_role_policy_attachment" "nodegroup_role" {
#   role       = data.aws_iam_role.nodegroup.name
#   policy_arn = data.aws_iam_policy.alb_policy.arn
# }

# resource "aws_iam_role_policy_attachment" "nodegroup_policies" {
#   for_each = toset(var.local-scripts.nodegroup_policies)
#   role       = data.aws_iam_role.nodegroup.name
#   policy_arn = each.value
# }

# resource "null_resource" "deploy_apis" {
#   for_each = toset(var.local-scripts.deploy_apis)
#   provisioner "local-exec" {
#     command = each.value
#   }
# }