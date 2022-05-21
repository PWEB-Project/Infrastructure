variable "password" {
  sensitive = true
}

resource "helm_release" "rabbitmq" {
  name       = "rabbitmq"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "rabbitmq"
  version    = "9.1.1"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_secret.rabbitmq-credentials
  ]
}

resource "kubernetes_secret" "rabbitmq-credentials" {
  metadata {
    name = "rabbitmq-credentials"
    labels = {
      "sensitive" = "true"
    }
  }
  data = {
    "rabbitmq-password" = var.password
  }
}
