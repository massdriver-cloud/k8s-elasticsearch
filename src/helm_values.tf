locals {
  helm_values = {
    clusterName = var.md_metadata.name_prefix
    nodeGroup   = "master"

    # The service that non master groups will try to connect to when joining the cluster
    # This should be set to clusterName + "-" + nodeGroup for your master group
    masterService = "${var.md_metadata.name_prefix}-${local.nodeGroup}"

    labels = var.md_metadata.default_tags
    resources = {
      requests = {
        cpu    = "${var.instance_configuration.cpu_limit}m"
        memory = "${var.instance_configuration.memory_limit}Gi"
      }
      limits = {
        cpu    = "${var.instance_configuration.cpu_limit}m"
        memory = "${var.instance_configuration.memory_limit}Gi"
      }
    }
    volumeClaimTemplate = {
      resources = {
        requests = {
          storage = "${var.instance_configuration.storage}Gi"
        }
      }
    }
    imageTag           = var.image_tag
    replicas           = var.replica_configuration.replicas
    minimumMasterNodes = (var.replica_configuration.replicas / 2) + 1
    secret = {
      password = random_password.es_secret.result
    }
  }
}
