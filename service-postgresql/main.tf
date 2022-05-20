resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "11.2.4"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]
}
