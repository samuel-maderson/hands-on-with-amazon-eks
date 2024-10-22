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