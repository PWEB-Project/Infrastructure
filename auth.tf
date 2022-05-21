resource "random_password" "postgresql_password" {
  length  = 32
  special = false
}

resource "random_password" "elasticsearch_password" {
  length  = 32
  special = false
}

resource "random_password" "rabbitmq_password" {
  length  = 32
  special = false
}
