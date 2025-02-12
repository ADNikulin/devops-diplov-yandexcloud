# https://yandex.cloud/ru/docs/storage/operations/buckets/create

resource "yandex_iam_service_account" "service_account" {
  folder_id = var.folder_id
  name      = var.service_account-name
}

resource "yandex_resourcemanager_folder_iam_member" "sa_editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.service_account.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static_key" {
  service_account_id = yandex_iam_service_account.service_account.id
  description        = "static access key for object storage"
}

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
}
