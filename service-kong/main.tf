resource "helm_release" "kong" {
  name       = "kong"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  version    = "2.8.2"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_config_map.kong-declarative-rules
  ]
}

resource "kubernetes_config_map" "kong-declarative-rules" {
  metadata {
    name = "kong-declarative-rules"
  }

  data = {
    "kong.yml" = file("${path.module}/kong.yml")
  }
}
