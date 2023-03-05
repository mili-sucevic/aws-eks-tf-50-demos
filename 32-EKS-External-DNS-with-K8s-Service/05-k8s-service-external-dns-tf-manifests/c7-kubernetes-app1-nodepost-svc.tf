# Kubernetes Service Manifest (Type: Node Port Service)
resource "kubernetes_service_v1" "myapp1_np_service" {
  metadata {
    name = "app1-nginx-loadbalancer-service"
    annotations = {
      "alb.ingress.kubernetes.io/healthcheck-path" = "/app1/index.html"
      "external-dns.alpha.kubernetes.io/hostname" = "tf-extdns-k8s-service-demo101.cmcloudlab837.info"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.myapp1.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}