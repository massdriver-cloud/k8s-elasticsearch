




[![Massdriver][logo]][website]

# k8s-elasticsearch

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]

<!--
##### STILL NEED TO GET SLACK WORKING ###
[!["Slack Community"](%s)][slack]
-->


Elasticsearch is a distributed, RESTful search and analytics engine capable of addressing a growing number of use cases.


---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`instance_configuration`** *(object)*
  - **`cpu_limit`** *(number)*: Unit is in CPUs. Decimal numbers are allowed (3 digits of precision). Value must be between 0.5 and 32. Minimum: `0.5`. Maximum: `32`.
  - **`memory_limit`** *(number)*: Unit is Gi. Decimal numbers are allowed. Value must be between 0.5 and 64. Minimum: `0.5`. Maximum: `64`.
  - **`storage`** *(integer)*: The size (in GiB) of the Elasticsearch instance. Must be an integer between 10 and 1000. Minimum: `10`. Maximum: `1000`.
- **`namespace`** *(string)*: Choose a namespace for Elasticsearch.
- **`replica_configuration`** *(object)*
  - **`replicas`** *(integer)*: Number of replicas to create. Must be an integer between 1 and 5. Minimum: `1`. Maximum: `5`.
## Examples

  ```json
  {
      "__name": "Development",
      "instance_configuration": {
          "cpu_limit": 1,
          "memory_limit": 2,
          "storage": 10
      },
      "replica_configuration": {
          "replicas": 1
      }
  }
  ```

  ```json
  {
      "__name": "Production",
      "instance_configuration": {
          "cpu_limit": 4,
          "memory_limit": 8,
          "storage": 50
      },
      "replica_configuration": {
          "replicas": 3
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`kubernetes_cluster`** *(object)*: Kubernetes cluster authentication and cloud-specific configuration. Cannot contain additional properties.
  - **`data`** *(object)*
    - **`authentication`** *(object)*
      - **`cluster`** *(object)*
        - **`certificate-authority-data`** *(string)*
        - **`server`** *(string)*
      - **`user`** *(object)*
        - **`token`** *(string)*
    - **`infrastructure`** *(object)*: Cloud specific Kubernetes configuration data.
      - **One of**
        - AWS EKS infrastructure config*object*: . Cannot contain additional properties.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`oidc_issuer_url`** *(string)*: An HTTPS endpoint URL.

            Examples:
            ```json
            "https://example.com/some/path"
            ```

            ```json
            "https://massdriver.cloud"
            ```

        - Azure Infrastructure Resource ID*object*: Minimal Azure Infrastructure Config. Cannot contain additional properties.
          - **`ari`** *(string)*: Azure Resource ID.

            Examples:
            ```json
            "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
            ```

        - GCP Infrastructure GRN*object*: Minimal GCP Infrastructure Config. Cannot contain additional properties.
          - **`grn`** *(string)*: GCP Resource Name (GRN).

            Examples:
            ```json
            "projects/my-project/global/networks/my-global-network"
            ```

            ```json
            "projects/my-project/regions/us-west2/subnetworks/my-subnetwork"
            ```

            ```json
            "projects/my-project/topics/my-pubsub-topic"
            ```

            ```json
            "projects/my-project/subscriptions/my-pubsub-subscription"
            ```

            ```json
            "projects/my-project/locations/us-west2/instances/my-redis-instance"
            ```

            ```json
            "projects/my-project/locations/us-west2/clusters/my-gke-cluster"
            ```

  - **`specs`** *(object)*
    - **`kubernetes`** *(object)*: Kubernetes distribution and version specifications.
      - **`cloud`** *(string)*: Must be one of: `['aws', 'gcp', 'azure']`.
      - **`distribution`** *(string)*: Must be one of: `['eks', 'gke', 'aks']`.
      - **`platform_version`** *(string)*
      - **`version`** *(string)*
<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`elasticsearch_authentication`** *(object)*: Elasticsearch cluster authentication and cloud-specific configuration. Cannot contain additional properties.
  - **`data`** *(object)*
    - **`authentication`**: Elasticsearch connection string. Cannot contain additional properties.
      - **`hostname`** *(string)*
      - **`password`** *(string)*
      - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
      - **`username`** *(string)*
    - **`infrastructure`** *(object)*: . Cannot contain additional properties.
      - **`kubernetes_namespace`** *(string)*
      - **`kubernetes_service`** *(string)*
  - **`specs`** *(object)*
    - **`elasticsearch`** *(object)*: Common metadata for Elasticsearch clusters.
      - **`version`** *(string)*: The Elasticsearch version. Default: ``.

        Examples:
        ```json
        "7.17.1"
        ```


      Examples:
      ```json
      {
          "version": "7.17.1"
      }
      ```

<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/k8s-elasticsearch/issues) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]

<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg
[docs]: https://docs.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=k8s-elasticsearch&utm_content=docs
[website]: https://www.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=k8s-elasticsearch&utm_content=website
[github]: https://github.com/massdriver-cloud?utm_source=github&utm_medium=readme&utm_campaign=k8s-elasticsearch&utm_content=github
[slack]: https://massdriverworkspace.slack.com/?utm_source=github&utm_medium=readme&utm_campaign=k8s-elasticsearch&utm_content=slack
[linkedin]: https://www.linkedin.com/company/massdriver/?utm_source=github&utm_medium=readme&utm_campaign=k8s-elasticsearch&utm_content=linkedin



[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/k8s-elasticsearch.svg?style=for-the-badge
[contributors_url]: https://github.com/massdriver-cloud/k8s-elasticsearch/graphs/contributors
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/k8s-elasticsearch.svg?style=for-the-badge
[forks_url]: https://github.com/massdriver-cloud/k8s-elasticsearch/network/members
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/k8s-elasticsearch.svg?style=for-the-badge
[stars_url]: https://github.com/massdriver-cloud/k8s-elasticsearch/stargazers
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/k8s-elasticsearch.svg?style=for-the-badge
[issues_url]: https://github.com/massdriver-cloud/k8s-elasticsearch/issues
[release_url]: https://github.com/massdriver-cloud/k8s-elasticsearch/releases/latest
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/k8s-elasticsearch.svg?style=for-the-badge
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/k8s-elasticsearch.svg?style=for-the-badge
[license_url]: https://github.com/massdriver-cloud/k8s-elasticsearch/blob/main/LICENSE


[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver?utm_source=github&utm_medium=readme&utm_campaign=k8s-elasticsearch&utm_content=twitter
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[discourse_url]: https://community.massdriver.cloud?utm_source=github&utm_medium=readme&utm_campaign=k8s-elasticsearch&utm_content=discourse
[discourse_shield]: https://img.shields.io/badge/join-Discourse-black.svg?style=for-the-badge&logo=discourse&color=000000
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
