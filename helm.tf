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
  source = "./service-elasticsearch"
}

module "service-kibana" {
  source = "./service-kibana"
}

module "service-rabbitmq" {
  source = "./service-rabbitmq"
}

module "service-prometheus-stack" {
  source = "./service-prometheus-stack"
}

module "service-mysql" {
  source = "./service-mysql"
}

module "service-postgresql" {
  source = "./service-postgresql"
}

module "service-adminer" {
  source = "./service-adminer"
}

module "service-kong" {
  source = "./service-kong"
}
