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
