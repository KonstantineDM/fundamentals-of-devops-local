resource "kubernetes_service_v1" "sample_app_loadbalancer" {
    metadata {
      name = "sample-app-loadbalancer"
    }

    spec {
        type = "LoadBalancer"

        selector = {
          app = "sample-app-pods"
        }

        port {
            protocol = "TCP"
            port = 80
            target_port = 8080
        }
    }
}