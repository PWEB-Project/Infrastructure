resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  version    = "7.17.3"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name  = "volumeClaimTemplate.storageClassName"
    value = "elasticsearch-ssd"
  }

  set {
    name  = "volumeClaimTemplate.resources.requests.storage"
    value = "2Gi"
  }

  set {
    name  = "imageTag"
    value = "7.17.3"
  }
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
