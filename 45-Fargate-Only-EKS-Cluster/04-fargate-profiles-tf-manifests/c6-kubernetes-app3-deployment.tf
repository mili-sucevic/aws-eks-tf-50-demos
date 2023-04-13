# Kubernetes Deployment Manifest
resource "kubernetes_deployment_v1" "myapp3" {
  metadata {
    name = "app3-nginx-deployment"
    namespace = "fp-ns-app1"    
    labels = {
      app = "app3-nginx"
    }
  } 
 
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "app3-nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "app3-nginx"
        }
      }

      spec {
        container {
          image = "headinthecloudsonline/nginx-app-03:1.0"
          name  = "app3-nginx"
          port {
            container_port = 80
          }
          }
        }
      }
    }
}
