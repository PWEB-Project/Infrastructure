resource "helm_release" "filebeat" {
  name       = "filebeat"
  repository = "https://helm.elastic.co"
  chart      = "filebeat"
  version    = "7.17.3"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]
}
