variable "password" {
  sensitive = true
}

resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "11.2.4"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_secret.postgresql-credentials
  ]
}

resource "kubernetes_secret" "postgresql-credentials" {
  metadata {
    name = "postgresql-credentials"
  }

  data = {
    "postgres-password" = var.password
    "password"          = var.password
  }
}
