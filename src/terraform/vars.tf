locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")
  ssh-private-keys = file("~/.ssh/id_ed25519")
}

data "template_file" "cloudinit" {
  template = file("${path.module}/inits/cloud-init.yml")
  vars = {
    ssh_public_key = local.ssh-keys
    # ssh_private_key = local.ssh-private-keys
  }
}

variable "os_image_master" {
  type    = string
  default = "ubuntu-2404-lts-oslogin"
}

data "yandex_compute_image" "ubuntu-master" {
  family = var.os_image_master
}

variable "os_image_worker" {
  type    = string
  default = "ubuntu-2404-lts-oslogin"
}

data "yandex_compute_image" "ubuntu-worker" {
  family = var.os_image_worker
}
