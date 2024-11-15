
alb_check=$(kubectl get pods -n kube-system |grep aws-load-balancer |grep -i running| wc -l)

if [ ! -n $alb_check ]; then

  aws eks update-kubeconfig --region us-east-1 --name eks-acg

  kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

  helm repo add eks https://aws.github.io/eks-charts

  helm upgrade --install \
    -n kube-system \
    --set clusterName=eks-acg \
    --set serviceAccount.create=true \
    aws-load-balancer-controller eks/aws-load-balancer-controller

  aws cloudformation deploy \
      --stack-name aws-load-balancer-iam-policy \
      --template-file iam-policy.yaml \
      --capabilities CAPABILITY_IAM

fi

