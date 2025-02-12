variable "_k8s_master_counts" {
  description = "numbers of count instances"
  type        = number
  default     = 1
}

variable "settings_k8s_master" {
  description = "instance settings for k8s master"
  type = object({
    instance = object({
      name          = string
      cores         = number
      memory        = number
      core_fraction = number
      platform_id   = string
    })
    boot_disk = object({
      size = number
      type = string
    })
  })

  default = {
    instance = {
      name          = "k8s-master-instance"
      core_fraction = 20
      cores         = 2
      memory        = 2
      platform_id   = "standard-v1"
    }

    boot_disk = {
      size = 20
      type = "network-hdd"
    }
  }
}

resource "yandex_compute_instance" "yc-k8s-master-instance" {
  count = var._k8s_master_counts

  name        = "${var.settings_k8s_master.instance.name}-${count.index + 1}"
  platform_id = var.settings_k8s_master.instance.platform_id

  resources {
    cores         = var.settings_k8s_master.instance.cores
    memory        = var.settings_k8s_master.instance.memory
    core_fraction = var.settings_k8s_master.instance.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-master.image_id
      type     = var.settings_k8s_master.boot_disk.type
      size     = var.settings_k8s_master.boot_disk.size
    }
  }

  metadata = {
    ssh-keys           = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
    user-data          = data.template_file.cloudinit.rendered
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.netology-subnet-a.id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }
}
