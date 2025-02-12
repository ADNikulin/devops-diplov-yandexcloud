variable "folder_id" {
  type        = string
  description = "https://yandex.cloud/ru/docs/resource-manager/operations/folder/get-id"
}

variable "cloud_id" {
  type        = string
  description = "https://yandex.cloud/ru/docs/resource-manager/operations/cloud/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://yandex.cloud/ru/docs/overview/concepts/geo-scope"
}

variable "bucket_name" {
  type        = string
  default     = "tf-bucket-state-netology-dm"
  description = "https://yandex.cloud/ru/docs/storage/concepts/bucket"
}

variable "service_account-name" {
  type        = string
  default     = "sa-tf-builder"
  description = "https://yandex.cloud/ru/docs/iam/operations/sa/create"
}