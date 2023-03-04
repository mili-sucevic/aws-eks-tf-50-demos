# Resource: Cluster Role
resource "kubernetes_cluster_role_v1" "eks_readonly_clusterrole" {
  metadata {
    name = "${local.name}-eks-readonly-clusterrole"
  }

  rule {
    api_groups = [""]                                                                                   # These come under core APIs
    resources  = ["nodes", "namespaces", "pods", "events", "services", "configmaps", "serviceaccounts"] #Uncomment for additional Testing
    #resources  = ["nodes", "namespaces", "pods", "events", "services", "configmaps", "serviceaccounts"] #Uncomment for additional Testing
    verbs = ["get", "list"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "daemonsets", "statefulsets", "replicasets"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list"]
  }
}

# Resource: Cluster Role Binding
resource "kubernetes_cluster_role_binding_v1" "eks_readonly_clusterrolebinding" {
  metadata {
    name = "${local.name}-eks-readonly-clusterrolebinding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.eks_readonly_clusterrole.metadata.0.name
  }
  subject {
    kind      = "Group"
    name      = "eks-readonly-group"
    api_group = "rbac.authorization.k8s.io"
  }
}
