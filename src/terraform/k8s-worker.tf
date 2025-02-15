variable "_k8s_worker_counts" {
  description = "numbers of count instances"
  type        = number
  default     = 2
}

variable "settings_k8s_worker" {
  description = "instance settings for k8s worker"
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
      name          = "k8s-worker-instance"
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

resource "yandex_compute_instance" "yc-k8s-worker-instance" {
  depends_on  = [yandex_compute_instance.yc-k8s-master-instance]
  count       = var._k8s_worker_counts

  name        = "${var.settings_k8s_worker.instance.name}-${count.index + 1}"
  platform_id = var.settings_k8s_worker.instance.platform_id
  zone        = var.ru-central1-b

  resources {
    cores         = var.settings_k8s_worker.instance.cores
    memory        = var.settings_k8s_worker.instance.memory
    core_fraction = var.settings_k8s_worker.instance.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-worker.image_id
      size     = var.settings_k8s_worker.boot_disk.size
      type     = var.settings_k8s_worker.boot_disk.type
    }
  }

  metadata = {
    ssh-keys           = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
    user-data          = data.template_file.cloudinit.rendered
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.netology-subnet-b.id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }
}
