# main.tf

terraform {
  required_providers {                     #### ansible provider
    ansible = {
      version = "~> 0.0.1"
      source  = "terraform-ansible.com/ansibleprovider/ansible"
    }
   # aws = {
   #   source  = "hashicorp/aws"
   #   version = "~> 4.0"
   # }
  }
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
