# https://yandex.cloud/ru/docs/storage/operations/buckets/create

# Используем ключ доступа для создания бакета
resource "yandex_storage_bucket" "yc_tf_bucket-netology_diplom" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.sa-static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static_key.secret_key

  anonymous_access_flags {
    read = false
    list = false
  }

  tags = {
    "bucket" = "netology"
  }

  force_destroy = true

  provisioner "local-exec" {
    command = "echo export ACCESS_KEY=${yandex_iam_service_account_static_access_key.sa-static_key.access_key} > ../terraform/backend.tfvars"
  }

  provisioner "local-exec" {
    command = "echo export SECRET_KEY=${yandex_iam_service_account_static_access_key.sa-static_key.secret_key} >> ../terraform/backend.tfvars"
  }

  provisioner "local-exec" {
    command = "yc iam key create --output ../terraform/sa-editor-key.json.tfvars --service-account-name ${yandex_iam_service_account.service_account.name}"
  }

  provisioner "local-exec" {
    command = "yc config set service-account-key ../terraform/sa-editor-key.json.tfvars && export YC_TOKEN=$(yc iam create-token)"
  }
}
