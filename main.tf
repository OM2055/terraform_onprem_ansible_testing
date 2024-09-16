terraform {
  cloud {
    organization = "Your_TF_Cloud_Organization"
    workspaces {
      name = "example-ansible-hello-world"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
  token    = var.tfe_token
}

# Null resource to run the Ansible playbook using local-exec
resource "null_resource" "ansible_hello_world" {
  provisioner "local-exec" {
    command = "ansible-playbook ./Ansible/hello_world.yml"
  }
}

# Ensure Ansible is only run once
#lifecycle {
#  create_before_destroy = true
# }
