resource "yandex_vpc_network" "netology" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "netology-subnet-a" {
  name           = "${var.vpc_name}-a"
  zone           = var.ru-central1-a
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = var.subnet_cidr-a
}

resource "yandex_vpc_subnet" "netology-subnet-b" {
  name           = "${var.vpc_name}-b"
  zone           = var.ru-central1-b
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = var.subnet_cidr-b
}
