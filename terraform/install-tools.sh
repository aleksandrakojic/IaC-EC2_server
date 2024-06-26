#!/bin/bash
# For Ubuntu 22.04

set -e # Exit script immediately on first error.

# Log all output to file
exec >> /var/log/init-script.log 2>&1

echo "Starting initialization script..."

# Update system
sudo apt update -y

# Install dependencies
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again
sudo apt-get update -y

# Install Docker Engine
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Enable and start Docker service
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo systemctl start docker.service
sudo systemctl start containerd.service
sudo systemctl status docker
docker --version

echo "Docker installation completed successfully!"


# Wait for Docker to initialize
sleep 10

# Run Docker Container of Sonarqube
docker run -d  --name sonar -p 9000:9000 sonarqube:lts-community

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install
aws --version
rm -rf awscliv2.zip

# Install Kubectl
sudo apt update
sudo apt install curl -y
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client
echo "kubectl installation completed successfully!"

# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
echo "eksctl installation completed successfully!"

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform -y
terraform --version
echo "Terraform installation completed successfully!"

# Install Trivy
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt update
sudo apt install trivy -y
trivy --version
echo "Trivy installation completed successfully!"

# Installing Helm
sudo snap install helm --classic
helm version

# Adding Helm repositories
helm repo add argo https://argoproj.github.io/argo-helm
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Installing Argo CD
helm install argocd argo/argo-cd --namespace argocd --create-namespace

# Installing Prometheus
helm install prometheus prometheus-community/prometheus --namespace monitoring --create-namespace

# Installing Grafana
helm install grafana grafana/grafana --namespace monitoring --create-namespace

echo "Initialization script completed successfully."

