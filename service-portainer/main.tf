resource "helm_release" "portainer" {
  name       = "portainer"
  repository = "https://portainer.github.io/k8s/"
  chart      = "portainer"
  version    = "1.0.30"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]
}
