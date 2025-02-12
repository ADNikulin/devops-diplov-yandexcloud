# todo: 
terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = var.bucket_name
    region                      = var.default_zone
    key                         = "${var.bucket_name}/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

# terraform {
#   required_providers {
#     yandex = {
#       source = "yandex-cloud/yandex"
#     }
#   }

#   backend "s3" {
#     endpoints = {
#       s3 = "https://storage.yandexcloud.net"
#     }
#     bucket = "<bucket_name>"
#     region = "ru-central1"
#     key    = "<path_to_state_file_in_bucket>/<state_file_name>.tfstate"

#     skip_region_validation      = true
#     skip_credentials_validation = true
#     skip_requesting_account_id  = true # This option is required for Terraform 1.6.1 or higher.
#     skip_s3_checksum            = true # This option is required to describe backend for Terraform version 1.6.3 or higher.

#   }
# }

# provider "yandex" {
#   zone      = "<default_availability_zone>"
# }