# Создаем группу балансировщика
resource "yandex_lb_target_group" "ylbtg-balancer_group" {
  name       = "k8s-balancer-group"
  depends_on = [yandex_compute_instance.yc-k8s-master-instance]

  dynamic "target" {
    for_each = concat(yandex_compute_instance.yc-k8s-worker-instance, yandex_compute_instance.yc-k8s-master-instance)
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

# Создаем балансировщик grafana
resource "yandex_lb_network_load_balancer" "nlb-grafana-app" {
  name = "grafana-app"

  listener {
    name        = "grafana-listener"
    port        = 80
    target_port = 30001
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.ylbtg-balancer_group.id
    healthcheck {
      name = "healthcheck"
      tcp_options {
        port = 30001
      }
    }
  }

  depends_on = [yandex_lb_target_group.ylbtg-balancer_group]
}

# Создаем балансировщик main-app
resource "yandex_lb_network_load_balancer" "nlb-main-app" {
  name = "main-app"
  listener {
    name        = "main-app-listener"
    port        = 80
    target_port = 30002
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.ylbtg-balancer_group.id
    healthcheck {
      name = "healthcheck"
      tcp_options {
        port = 30002
      }
    }
  }
  depends_on = [yandex_lb_network_load_balancer.nlb-grafana-app]
}
