main = {
  aws_alb_policy = "arn:aws:iam::471112996485:policy/aws-load-balancer-iam-policy-iamPolicy-IUAKHYEmkgaZ"
  eksnodegroup_role = "eksctl-eks-acg-nodegroup-eks-node--NodeInstanceRole-0QpPAVkVesdS"
  nodegroup_policies = [
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]

  deploy_apis = [
    "cd ../inventory-api/infra/cloudformation/ && ./create-dynamodb-table.sh development",
    "cd ../renting-api/infra/cloudformation/ && ./create-dynamodb-table.sh development",
    "cd ../resource-api/infra/cloudformation/ && ./create-dynamodb-table.sh development",
  ]
}