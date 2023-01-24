resource "kubernetes_deployment_v1" "myapp1" {
  metadata {
    name = "myapp1-deployment"
    labels = {
      test = "myapp1"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "myapp1"
      }
    }

    template {
      metadata {
        labels = {
          app = "myapp1"
        }
      }

      spec {
        container {
          image = "stacksimplify/kubenginx:1.0.0"
          name  = "myapp1-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}