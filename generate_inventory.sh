#!/bin/bash

if [ -z "$1" ]; then
  read -p "Enter the private SSH key path: " SSH_KEY_PATH
else
  SSH_KEY_PATH="$1"
fi

MASTER_IP=$(terraform output -raw k8_master_ip)
WORKER_IPS=$(terraform output -json k8_worker_ips | jq -r '.[]')

cat <<EOF > inventory.ini
[k8s_master]
$MASTER_IP

[k8s_worker]
EOF

for IP in $WORKER_IPS; do
  echo $IP >> inventory.ini
done

cat <<EOF >> inventory.ini

[all:vars]
ansible_ssh_private_key_file=$SSH_KEY_PATH
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF

echo "Inventory file generated successfully"