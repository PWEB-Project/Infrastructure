resource "helm_release" "mysql" {
  name       = "mysql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mysql"
  version    = "9.0.2"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]
}
