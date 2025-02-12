###cloud vars

variable "cloud_id" {
  type        = string
  description = "https://yandex.cloud/ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://yandex.cloud/ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://yandex.cloud/ru/docs/overview/concepts/geo-scope"
}

variable "ru-central1-a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://yandex.cloud/ru/docs/overview/concepts/geo-scope"
}

variable "ru-central1-b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://yandex.cloud/ru/docs/overview/concepts/geo-scope"
}

variable "subnet_cidr-a" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://yandex.cloud/ru/docs/vpc/operations/subnet-create"
}

variable "subnet_cidr-b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://yandex.cloud/ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "netology-dm"
  description = "https://yandex.cloud/ru/docs/vpc/operations/network-create#tf_2"
}
