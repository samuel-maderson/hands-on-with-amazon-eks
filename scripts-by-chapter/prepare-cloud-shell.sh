

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

echo "---------- INSTALLING KUBECTL ----------"
curl -LO https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl
sudo mv kubectl /usr/local/bin
sudo chmod +x /usr/local/bin/kubectl


echo "---------- TERRAFORM CLEAN ----------"
sudo rm -rf /opt/iac/terraform.tfstate*
sudo rm -rf /opt/iac/.terraform*

echo "---------- INSTALLING TERRAFORM ----------"
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform -y


echo "---------- MAKING INFRASTRUCTURE LINK ----------"
if [ ! -d "Infrastructure" ]; then
    ln -s ../Infrastructure Infrastructure
else
    echo "Infrastructure link already exists"
fi
