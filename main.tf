# main.tf
terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.42.0"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
  token    = var.tfe_token
}


provider "tls" {}

provider "local" {}

provider "null" {}

provider "ssh" {
  host        = var.vm_ip_address
  user        = var.ssh_user
  private_key = file(var.private_key_path)
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Execute the yum install command on the on-prem VM
resource "null_resource" "install_wget" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = var.vm_ip_address
      user        = var.ssh_user
      private_key = file(var.private_key_path)
    }

    inline = [
      "sudo yum install -y wget"
    ]
  }
}

# Output the result
output "ssh_host" {
  value = var.vm_ip_address
}
