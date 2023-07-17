## IAM permissions

The Role required to deploy this GKE module is:

```json
 [
    "compute.firewalls.create",
    "compute.firewalls.delete",
    "compute.firewalls.get",
    "compute.firewalls.update",
    "compute.instanceGroupManagers.get",
    "compute.networks.updatePolicy",
    "compute.subnetworks.get",
    "compute.zones.list",
    "container.clusters.create",
    "container.clusters.delete",
    "container.clusters.get",
    "container.clusters.update",
    "container.operations.get",
    "iam.serviceAccountKeys.create",
    "iam.serviceAccountKeys.get",
    "iam.serviceAccounts.actAs",
    "iam.serviceAccounts.create",
    "iam.serviceAccounts.delete",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.update",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.setIamPolicy"
  ]
```