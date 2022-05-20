resource "helm_release" "prometheus" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "35.2.0"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_secret.prometheus-additional-configs,
    kubernetes_config_map.grafana-dashboards-infra
  ]
}

resource "helm_release" "prometheus-elasticsearch" {
  name       = "prometheus-elasticsearch-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-elasticsearch-exporter"
  version    = "4.12.0"
  timeout    = 900

  values = [
    file("${path.module}/elasticsearch.yaml")
  ]
}

resource "kubernetes_secret" "prometheus-additional-configs" {
  metadata {
    name = "prometheus-additional-configs"
    labels = {
      "sensitive" = "true"
      "app"       = "prometheus"
    }
  }
  data = {
    "additional-configs.yaml" = file("${path.module}/additional-configs.yaml")
  }
}

resource "kubernetes_config_map" "grafana-dashboards-infra" {
  metadata {
    name = "grafana-dashboard-infra"

    labels = {
      grafana_dashboard = 1
    }

    annotations = {
      k8s-sidecar-target-directory = "/tmp/dashboards/Infra"
    }
  }

  data = {
    "rabbitmq.json"           = file("${path.module}/dashboards/rabbitmq.json")
    "elasticsearch.json"      = file("${path.module}/dashboards/elasticsearch.json")
  }
}
