locals {
  helm_values = {
    clusterName = var.md_metadata.name_prefix
    nodeGroup   = "master"

    # The service that non master groups will try to connect to when joining the cluster
    # This should be set to clusterName + "-" + nodeGroup for your master group
    masterService = "${var.md_metadata.name_prefix}-master"

    labels = var.md_metadata.default_tags
    resources = {
      requests = {
        cpu    = "${var.instance_configuration.cpu_limit}"
        memory = "${var.instance_configuration.memory_limit}Gi"
      }
      limits = {
        cpu    = "${var.instance_configuration.cpu_limit}"
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
    namespace          = var.namespace
    replicas           = var.replica_configuration.replicas
    minimumMasterNodes = floor(var.replica_configuration.replicas / 2) + 1
    extraEnvs = [{
      name  = "ELASTIC_PASSWORD"
      value = random_password.es_secret.result
    }]
  }
}
