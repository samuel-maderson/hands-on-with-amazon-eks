main = {
aws_alb_policy = "arn:aws:iam::891377197101:policy/aws-load-balancer-iam-policy-iamPolicy-AweICLTgamiQ"
eksnodegroup_role = "eksctl-eks-acg-nodegroup-eks-node--NodeInstanceRole-cD0Fle5Xa8Gq"
  nodegroup_policies = [
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]

  dynamodb_table_apis = [
    "cd ../inventory-api/infra/cloudformation/ && ./create-dynamodb-table.sh development",
    "cd ../renting-api/infra/cloudformation/ && ./create-dynamodb-table.sh development",
    "cd ../resource-api/infra/cloudformation/ && ./create-dynamodb-table.sh development",
    "cd ../clients-api/infra/cloudformation/ && ./create-dynamodb-table.sh development"
  ]

  deploy_apis = [
    "cd ../inventory-api/infra/helm && ./create.sh",
    "cd ../renting-api/infra/helm && ./create.sh",
    "cd ../resource-api/infra/helm && ./create.sh",
    "cd ../front-end/infra/helm && ./create.sh",
    "cd ../clients-api/infra/helm && ./create.sh"
  ]
}