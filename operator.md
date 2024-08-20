## Kubernetes Elasticsearch

Elasticsearch is a powerful open-source search and analytics engine capable of ingesting large volumes of data and providing near real-time search capabilities. This guide helps you effectively manage Elasticsearch clusters deployed on Kubernetes.

### Design Decisions

1. **Helm for Deployment**: This module uses Helm to deploy Elasticsearch on Kubernetes, leveraging Helm's templating system for advanced configurations.
2. **Kubernetes Resources Configuration**: It allows detailed settings for CPU, memory, and storage to tailor to different use cases.
3. **Scalability**: Designed to easily scale by adjusting the number of replicas and other parameters.
4. **Security**: Randomized password generation for Elasticsearch authentication, ensuring a secure setup.
5. **Namespace Isolation**: Each Elasticsearch deployment is isolated within its Kubernetes namespace for better management and security.

### Runbook

#### Elasticsearch Cluster Not Starting

If the Elasticsearch cluster is not coming up, check the following:

Retrieve the logs of the pod to identify any issues.

```sh
kubectl logs -n <namespace> <elasticsearch-pod>
```

Inspect the events in the namespace to understand resource issues or configuration errors.

```sh
kubectl get events -n <namespace>
```

#### High Memory Usage

If Elasticsearch pods are consuming a lot of memory, check the memory allocation and current usage:

```sh
kubectl top pod -n <namespace>
```

Examine Elasticsearch's `_nodes/stats` endpoint to get detailed memory usage information.

```sh
curl -u elastic:<password> -X GET "<elasticsearch-endpoint>/_nodes/stats?pretty"
```

#### Issues with Cluster Forming

If the Elasticsearch cluster is having trouble forming, look for network issues or misconfiguration:

Verify the service endpoints in your cluster.

```sh
kubectl get svc -n <namespace>
```

Check Elasticsearch cluster health for any node issues.

```sh
curl -u elastic:<password> -X GET "<elasticsearch-endpoint>/_cluster/health?pretty"
```

#### Password Authentication Issues

If facing issues with password authentication, ensure that the password was set correctly.

Retrieve the value of the generated secret.

```sh
kubectl get secret -n <namespace> <secret-name> -o jsonpath="{.data.elastic}"
echo "<retrieved-password>" | base64 --decode
```

#### Persistent Volume Claims (PVC) Issues

If PVCs are not being bound, check the status of PVCs in your namespace:

```sh
kubectl get pvc -n <namespace>
```

Describe the specific PVC to get more details.

```sh
kubectl describe pvc <pvc-name> -n <namespace>
```

#### Data Node Restart Loop

If data nodes are in a restart loop, inspect the pod events and logs for errors:

```sh
kubectl describe pod <pod-name> -n <namespace>
kubectl logs <pod-name> -n <namespace>
```

For deeper insights, check Elasticsearch logs within the pod.

```sh
kubectl exec -it <pod-name> -n <namespace> -- cat /usr/share/elasticsearch/logs/elasticsearch.log
```

Use these troubleshooting steps to resolve common issues with Elasticsearch on Kubernetes effectively.

