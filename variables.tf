# variables.tf

variable "vm_ip_address" {
  description = "The IP address of the on-prem VM."
  type        = string
}

variable "ssh_user" {
  description = "The SSH username for the VM."
  type        = string
}

variable "private_key_path" {
  description = "The path to the SSH private key to access the VM."
  type        = string
}
