locals {
  data_authentication = {
    username = "elastic"
    password = random_password.es_secret.result
    hostname = "https://${local.release}.${var.namespace}.svc.cluster.local"
    port     = 9200
  }
}

resource "massdriver_artifact" "authentication" {
  field                = "elasticsearch_authentication"
  provider_resource_id = "${var.namespace}/${local.data_authentication.hostname}"
  name                 = "Elastic at ${var.namespace}/${local.data_authentication.hostname}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = {
          kubernetes_service   = local.release
          kubernetes_namespace = var.namespace
        }
        authentication = local.data_authentication
      }
      specs = {
        elasticsearch = {
          version = "7.17.1"
        }
      }
    }
  )
}
