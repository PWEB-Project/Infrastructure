provider "helm" {
  kubernetes {
    host                   = google_container_cluster.primary.endpoint
    token                  = data.google_client_config.provider.access_token
    client_certificate     = base64decode(google_container_cluster.primary.master_auth.0.client_certificate)
    client_key             = base64decode(google_container_cluster.primary.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  }
}

module "service-elasticsearch" {
  source   = "./service-elasticsearch"
  password = random_password.elasticsearch_password.result
}

module "service-kibana" {
  source = "./service-kibana"

  depends_on = [
    module.service-elasticsearch
  ]
}

module "service-rabbitmq" {
  source   = "./service-rabbitmq"
  password = random_password.rabbitmq_password.result
}

module "service-prometheus-stack" {
  source                 = "./service-prometheus-stack"
  elasticsearch_password = random_password.elasticsearch_password.result
  postgresql_password    = random_password.postgresql_password.result

  depends_on = [
    module.service-elasticsearch
  ]
}

module "service-postgresql" {
  source   = "./service-postgresql"
  password = random_password.postgresql_password.result
}

module "service-adminer" {
  source = "./service-adminer"
}

module "service-kong" {
  source = "./service-kong"
}

module "service-portainer" {
  source = "./service-portainer"
}

module "service-filebeat" {
  source = "./service-filebeat"

  depends_on = [
    module.service-elasticsearch
  ]
}
