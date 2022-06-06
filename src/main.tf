locals {
  chart_version = "8.1.0"
  es_version    = "8.1.0"
  release       = var.md_metadata.name_prefix
}

# resource "random_password" "es_secret" {
#   length  = 10
#   special = false
# }

resource "helm_release" "elasticsearch" {
  name             = local.release
  chart            = "elasticsearch"
  repository       = "https://helm.elastic.co"
  version          = local.chart_version
  namespace        = "Elasticsearch" # var.namespace
  create_namespace = true

  # values = [
  #   "${file("${path.module}/values.yaml")}",
  #   yamlencode(local.helm_values)
  # ]
}
