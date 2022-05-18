resource "helm_release" "kibana" {
  name       = "kibana"
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  version    = "7.17.3"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]
}
