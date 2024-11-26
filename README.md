# K8s-bootstrap
Get a simple K8s cluster up and running in minutes using Terraform and Ansible.

Only works on GCP for now.

## Prerequisites
- [Terraform](https://www.terraform.io/downloads.html)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [GCP account](https://cloud.google.com/)
- [GCP CLI](https://cloud.google.com/sdk/docs/install)
- [Ansible role](https://galaxy.ansible.com/ui/standalone/roles/TalhaJuikar/kubernetes/):
   - `ansible-galaxy role install TalhaJuikar.kubernetes`

## Usage
1. Clone the repository
2. Create a new project in GCP or use an existing one. Make sure you have the necessary permissions.
3. Enable the Compute Engine API
4. Authenticate with GCP. [See](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference) 
   - `gcloud auth application-default login`

5. Create a new SSH key pair
   - `ssh-keygen -t rsa -b 4096 -C Your-username`
6. Create the `terraform.tfvars` file with following values:
   ```
      project_id = "your-project-id"
      region = "your-region"
      zone = "your-zone"
      instance_type = "instance-type"
      image = "your-image"
      disk_size = "disk-size"
      ssh_public_key = "ssh-public-key"
   ```
7. Run bash script `./bootstrap.sh` to create the infrastructure and install K8s.
   ```bash
   bash bootstrap.sh
   ```
   - You can specify the ssh key path as an argument to the script.
      ```bash
      bash bootstrap.sh /path/to/ssh-private-key
      ```

## Clean up
1. Run the bash script `./cleanup.sh` to delete the infrastructure.
   ```bash
   bash cleanup.sh
   ```