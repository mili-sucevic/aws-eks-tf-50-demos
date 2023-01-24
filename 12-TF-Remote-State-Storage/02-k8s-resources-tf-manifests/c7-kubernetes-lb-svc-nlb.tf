resource "kubernetes_service_v1" "lb-service-nlb" {
  metadata {
    name = "myapp1-lb-service-nlb"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb" # To create Network Load Balancer  
    }
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
