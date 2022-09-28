provider “kubernetes” {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}


resource “kubernetes_namespace” “dev” {
  metadata {
    name = “nginx”
  }
}
resource “kubernetes_deployment” “dev” {
  metadata {
    name      = “nginx”
    namespace = kubernetes_namespace.dev.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = “cinema_microservice”
      }
    }
    template {
      metadata {
        labels = {
          app = “cinema_microservice”
        }
      }
      spec {
        container {
          image = “nginx”
          name  = “nginx-container”
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
resource “kubernetes_service” “dev” {
  metadata {
    name      = “nginx”
    namespace = kubernetes_namespace.dev.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.dev.spec.0.template.0.metadata.0.labels.app
    }
    type = “LoadBalancer”
    port {
      port        = 80
      target_port = 80
    }
  }
}
