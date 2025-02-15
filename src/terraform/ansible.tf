resource "local_file" "lf-hosts_config_kubespray" {
  content  = templatefile("${path.module}/templates/hosts.tftpl", {
    workers = yandex_compute_instance.yc-k8s-worker-instance
    masters = yandex_compute_instance.yc-k8s-master-instance
  })
  filename = "../kubespray/inventory/mycluster/hosts.yaml"
}