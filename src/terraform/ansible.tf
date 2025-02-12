resource "local_file" "lf-hosts_config_kubespray" {
  content  = templatefile("${path.module}/templates/hosts.tftpl", {
    workers = yandex_compute_instance.worker
    masters = yandex_compute_instance.master
  })
  filename = "../kubespray/inventory/mycluster/hosts.yaml"
}