resource "null_resource" "client_api_iam_policy" {
  for_each = toset(var.sa-apis.apis_policies)
  provisioner "local-exec" {
    command = "${each.value} development"
  }
}