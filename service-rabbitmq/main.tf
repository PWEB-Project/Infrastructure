resource "helm_release" "rabbitmq" {
  name       = "rabbitmq"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "rabbitmq"
  version    = "9.1.1"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]
}
