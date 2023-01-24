resource "kubernetes_service_v1" "lb-service" {
  metadata {
    name = "myapp1-lb-service"
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.myapp1.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      port        = 80 # Service Port
      target_port = 80 # Container Port
    }

    type = "LoadBalancer"
  }
}
