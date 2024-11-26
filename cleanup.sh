#!/bin/bash
set -e

echo "Destroying the Kubernetes cluster..."
echo "Are you sure you want to destroy the Kubernetes cluster?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) terraform destroy -auto-approve; break;;
        No ) exit;;
    esac
done
if [ $? -eq 0 ]; then
  echo "Kubernetes cluster destroyed successfully"
else
  echo "Failed to destroy Kubernetes cluster"
fi