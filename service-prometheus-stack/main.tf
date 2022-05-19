resource "helm_release" "prometheus" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "35.2.0"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]
}
