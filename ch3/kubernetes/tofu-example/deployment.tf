resource "kubernetes_deployment_v1" "sample_app" {
    metadata {
        name = "sample-app-deployment"
    }

    spec {
        replicas = 3

        template {
            metadata {
                labels = {
                    app = "sample-app-pods"
                }
            }

            spec {
                container {
                    name = "sample-app"
                    image = "sample-app:v3"
                    port {
                        container_port = 8080
                    }
                    env {
                        name = "NODE_ENV"
                        value = "production"
                    }
                }
            }
        }

        selector {
            match_labels = {
                app = "sample-app-pods"
            }
        }

        strategy {
            type = "RollingUpdate"
            rolling_update {
                max_surge = 3
                max_unavailable = 0
            }
        }
    }
}
