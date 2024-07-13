provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "default" {}

resource "google_container_cluster" "primary" {
  name     = "ashu-cloud"
  location = var.region
  deletion_protection  = false
  initial_node_count = 1

}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    machine_type = "e2-micro"
    disk_size_gb = 10 # Adjust disk size if needed to avoid quota issues
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  
}

resource "kubernetes_namespace" "backend" {
  metadata {
    name = "backend"
  }
}

resource "kubernetes_namespace" "frontend" {
  metadata {
    name = "frontend"
  }
}

resource "kubernetes_deployment" "backend" {
  depends_on = [google_container_cluster.primary, kubernetes_namespace.backend]

  metadata {
    name      = "backend-deployment"
    namespace = kubernetes_namespace.backend.metadata[0].name
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          image = "gcr.io/regal-scholar-423322-h0/my-backend:latest"
          name  = "backend"

          port {
            container_port = 5000
          }

          env {
            name  = "PGHOST"
            value = "34.72.51.3"
          }

          env {
            name  = "PGDATABASE"
            value = "postgres"
          }

          env {
            name  = "PGUSER"
            value = "postgres"
          }

          env {
            name  = "PGPASSWORD"
            value = "Ashu123"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend" {
  depends_on = [google_container_cluster.primary, kubernetes_namespace.backend]

  metadata {
    name      = "backend-service"
    namespace = kubernetes_namespace.backend.metadata[0].name
  }

  spec {
    selector = {
      app = "backend"
    }

    port {
      protocol = "TCP"
      port     = 5000
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "frontend" {
  depends_on = [google_container_cluster.primary, kubernetes_namespace.frontend]

  metadata {
    name      = "frontend-deployment"
    namespace = kubernetes_namespace.frontend.metadata[0].name
    labels = {
      app = "frontend"
    }
    annotations = {
      "kubectl.kubernetes.io/restartedAt" = timestamp()  # Forces a redeploy
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          image = "gcr.io/regal-scholar-423322-h0/my-frontend:latest"
          name  = "frontend"

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  depends_on = [google_container_cluster.primary, kubernetes_namespace.frontend]

  metadata {
    name      = "frontend-service"
    namespace = kubernetes_namespace.frontend.metadata[0].name
  }

  spec {
    selector = {
      app = "frontend"
    }

    port {
      protocol = "TCP"
      port     = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}

output "frontend_ip" {
  value = kubernetes_service.frontend.status[0].load_balancer[0].ingress[0].ip
}

output "backend_ip" {
  value = kubernetes_service.backend.status[0].load_balancer[0].ingress[0].ip
}