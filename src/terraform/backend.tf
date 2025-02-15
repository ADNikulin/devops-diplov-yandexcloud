# todo: 
terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket                      = "tf-bucket-state-netology-dm"
    region                      = "ru-central1-a"
    key                         = "tf-bucket-state-netology-dm/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
