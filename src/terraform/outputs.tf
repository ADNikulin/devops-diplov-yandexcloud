output "output_all_instance" {
  value = flatten([
    [for i in yandex_compute_instance.yc-k8s-master-instance : {
      name = i.name
      ip_external   = i.network_interface[0].nat_ip_address
      ip_internal = i.network_interface[0].ip_address
    }],
    [for i in yandex_compute_instance.yc-k8s-worker-instance : {
      name = i.name
      ip_external   = i.network_interface[0].nat_ip_address
      ip_internal = i.network_interface[0].ip_address
    }]
  ])
}

output "grafana-instance" {
  value = yandex_lb_network_load_balancer.nlb-grafana-app.listener.*.external_address_spec[0].*.address
  description = "Адрес сетевого балансировщика для Grafana"
}

output "main-app-instance" {
  value = yandex_lb_network_load_balancer.nlb-main-app.listener.*.external_address_spec[0].*.address
  description = "Адрес сетевого балансировщика Web App"
}