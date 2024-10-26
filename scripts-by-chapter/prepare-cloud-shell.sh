

echo "---------- INSTALLING NANO ----------"
# how to do an if to check if the return is true or false
LINUX_TYPE=$(cat /etc/issue|grep -i centos)
if [ $LINUX_TYPE  ]; then
    sudo yum install nano -y
else
    sudo apt-get install nano -y
fi

echo "---------- INSTALLING EKSCTL ----------"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/v0.193.0/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version


echo "---------- INSTALLING HELM ----------"
export VERIFY_CHECKSUM=false
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash


echo "---------- INSTALLING AWSCLI ----------"
rm -rf /usr/local/aws-cli
rm -rf aws*
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo aws/install


echo "---------- MAKING INFRASTRUCTURE LINK ----------"
if [ ! -d "Infrastructure" ]; then
    ln -s ../Infrastructure Infrastructure
else
    echo "Infrastructure link already exists"
fi
