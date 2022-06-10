# locals {
#   helm_values = {
#     labels = var.md_metadata.default_tags
#     resources = {
#       requests = {
#         cpu    = "${var.instance_configuration.cpu_limit}m"
#         memory = "${var.instance_configuration.memory_limit_gib}Gi"
#       }
#       limits = {
#         cpu    = "${var.instance_configuration.cpu_limit}m"
#         memory = "${var.instance_configuration.memory_limit_gib}Gi"
#       }
#     }
#     volumeClaimTemplate = {
#       resources = {
#         requests = {
#           storage = "${var.instance_configuration.storage}Gi"
#         }
#       }
#     }
#     replicas = var.replica_configuration.replicas
#     secret = {
#       password = random_password.es_secret.result
#     }
#   }
# }