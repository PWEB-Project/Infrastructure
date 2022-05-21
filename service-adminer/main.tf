resource "helm_release" "adminer" {
  name       = "adminer"
  repository = "https://cetic.github.io/helm-charts"
  chart      = "adminer"
  version    = "0.1.7"
  timeout    = 900

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_config_map.adminer-plugins,
    kubernetes_config_map.adminer-plugins-enabled
  ]
}

resource "kubernetes_config_map" "adminer-plugins" {
  metadata {
    name = "adminer-plugins"
  }

  data = {
    "AdminerCollations.php"   = file("${path.module}/plugins/AdminerCollations.php")
    "AdminerJsonPreview.php"  = file("${path.module}/plugins/AdminerJsonPreview.php")
    "AdminerLoginServers.php" = file("${path.module}/plugins/AdminerLoginServers.php")
    "AdminerSimpleMenu.php"   = file("${path.module}/plugins/AdminerSimpleMenu.php")
  }
}

resource "kubernetes_config_map" "adminer-plugins-enabled" {
  metadata {
    name = "adminer-plugins-enabled"
  }

  data = {
    "AdminerCollations.php"   = file("${path.module}/plugins-enabled/AdminerCollations.php")
    "AdminerJsonPreview.php"  = file("${path.module}/plugins-enabled/AdminerJsonPreview.php")
    "AdminerLoginServers.php" = file("${path.module}/plugins-enabled/AdminerLoginServers.php")
    "AdminerSimpleMenu.php"   = file("${path.module}/plugins-enabled/AdminerSimpleMenu.php")
  }
}
