#!/bin/bash
set -e

echo "Initializing Terraform..."
terraform init
echo "Validating Terraform configuration..."
terraform validate
echo "Planning Terraform configuration..."
terraform plan
echo "Applying Terraform configuration..."
terraform apply -auto-approve

echo "Waiting for the instances to boot up..."
sleep 30

echo "Generating inventory file..."
bash ./generate_inventory.sh

echo "Running Ansible playbook..."
echo "Creating the Kubernetes cluster..."
echo "Please wait, this may take a while..."
ansible-playbook -i inventory.ini bootstrap.yml

if [ $? -eq 0 ]; then
  echo "Kubernetes cluster created successfully"
  ControlPlaneIP=$(terraform output -raw k8_master_ip)
  echo "Control Plane IP: $ControlPlaneIP"
else
  echo "Failed to create Kubernetes cluster"
fi
