# Kubernetes Deployment Manifest
resource "kubernetes_deployment_v1" "app-01" {
  metadata {
    name = "app-01-nginx-deployment"
    labels = {
      app = "app-01-nginx"
    }    
  } 
 
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "app-01-nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "app-01-nginx"
        }
      }

      spec {
        container {
          image = "headinthecloudsonline/nginx-app-01:1.0"
          name  = "app-01-nginx"
          port {
            container_port = 80
          }
          }
        }
      }
    }
}
