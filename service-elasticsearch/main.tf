variable "password" {
  sensitive = true
}

resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  version    = "7.17.3"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_secret.elasticsearch-master-credentials
  ]
}

resource "kubernetes_storage_class" "elasticsearch_ssd" {
  metadata {
    name = "elasticsearch-ssd"
  }
  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"
  parameters = {
    type = "pd-ssd"
  }
  allow_volume_expansion = true
}

resource "kubernetes_secret" "elasticsearch-master-credentials" {
  metadata {
    name = "elasticsearch-master-credentials"
  }

  data = {
    "username" = "admin"
    "password" = var.password
  }
}
