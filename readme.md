# Module - Oracle Autonomous VM Cluster
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![OCI](https://img.shields.io/badge/provider-OCI-red)](https://registry.terraform.io/providers/oracle/oci/latest)

Module developed to standardize the creation of Oracle Autonomous VM Cluster.

## Compatibility Matrix

| Module Version | Terraform Version | OCI Version     |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.9.5            | 6.8.0           |

## Specifying a version

To avoid that your code get the latest module version, you can define the `?ref=***` in the URL to point to a specific version.
Note: The `?ref=***` refers a tag on the git module repo.

## Default use case
```hcl
module "aut-<region>-<env>-<system>-vm<id>" {    
  source = "git::https://github.com/danilomnds/terraform-oci-autonomous-vm-cluster?ref=v1.0.0"
  compartment_id = <compartment id>
  cpu_core_count_per_node = <10>  
  display_name = "aut-vcp-prd-coe-vm001"
  exadata_infrastructure_id = <exadata infrastructure cluster id>
  vm_cluster_network_id = <snet exadata>  
  time_zone = "America/Sao_Paulo"
  defined_tags = {
    "IT.area":"infrastructure"
    "IT.department":"ti"    
  }
}
output "autonomous-vmcluster-display-name" {
  value = module.aut-<region>-<env>-<system>-vm<id>.display_name
}
output "autonomous-vmcluster-id" {
  value = module.aut-<region>-<env>-<system>-vm<id>.id
}
```

## Default use case plus RBAC
```hcl
module "aut-<region>-<env>-<system>-vm<id>" {    
  source = "git::https://github.com/danilomnds/terraform-oci-autonomous-vm-cluster?ref=v1.0.0"
  compartment_id = <compartment id>
  cpu_core_count_per_node = <10>  
  display_name = "aut-vcp-prd-coe-vm001"
  exadata_infrastructure_id = <exadata infrastructure cluster id>
  vm_cluster_network_id = <snet exadata>  
  time_zone = "America/Sao_Paulo"
  defined_tags = {
    "IT.area":"infrastructure"
    "IT.department":"ti"    
  }
  compartment = <compartment name>
  # GRP_OCI_APP-ENV is the Azure AD group that you are going to grant the permissions
  groups = ["OracleIdentityCloudService/GRP_OCI_APP-ENV", "group name 2"]
}
output "autonomous-vmcluster-display-name" {
  value = module.aut-<region>-<env>-<system>-vm<id>.display_name
}
output "autonomous-vmcluster-id" {
  value = module.aut-<region>-<env>-<system>-vm<id>.id
}
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autonomous_data_storage_size_in_tbs | The data disk group size to be allocated for Autonomous Databases, in TBs | `string` | n/a | No |
| compartment_id | the ocid of the compartment | `string` | n/a | `Yes` |
| compute_model | The compute model of the Autonomous VM Cluster. ECPU compute model is the recommended model and OCPU compute model is legacy | `string` | `ECPU` | No |
| cpu_core_count_per_node | The number of CPU cores to enable per VM cluster node | `string` | n/a | `Yes` |
| db_servers | The list of DB servers | `list(string)` | n/a | No |
| defined_tags | Defined tags for this resource | `map(string)` | n/a | No |
| display_name | the user-friendly name for the cloud exadata infrastructure | `string` | n/a | `Yes` |
| exadata_infrastructure_id | The OCID of the cloud Exadata infrastructure resource | `string` | n/a | `Yes` |
| freeform_tags | Free-form tags for this resource | `map(string)` | n/a | No |
| is_local_backup_enabled | If true, database backup on local Exadata storage is configured for the cloud VM cluster | `bool` | n/a | No |
| is_mtls_enabled | Enable mutual TLS(mTLS) authentication for database while provisioning a VMCluster | `bool` | n/a | No |
| license_model | If true, database backup on local Exadata storage is configured for the cloud VM cluster | `string` | `BRING_YOUR_OWN_LICENSE` | No |
| maintenance_window_details | The scheduling details for the quarterly maintenance window | `object({})` | n/a | No |
| memory_per_oracle_compute_unit_in_gbs | The amount of memory (in GBs) to be enabled per OCPU or ECPU | `number` | n/a | No |
| scan_listener_port_non_tls | The SCAN Listener Non TLS port number. Default value is 1521| `number` | n/a | No |
| scan_listener_port_tls | The TCPS Single Client Access Name (SCAN) port. The default port is 2484 | `number` | n/a | No |
| time_zone | The time zone to use for the Autonomous VM cluster | `string` | n/a | No |
| total_container_databases | The total number of Autonomous Container Databases that can be created | `number` | n/a | No |
| vm_cluster_network_id | The OCID of the VM cluster network| `string` | n/a | No |
| groups | list of azure AD groups that will manage objects inside the bucket | `list(string)` | `[]` | No |
| compartment | compartment name that will be used for policy creation | `string` | n/a | No |

# Object variables for blocks

| Variable Name (Block) | Parameter | Description | Type | Default | Required |
|-----------------------|-----------|-------------|------|---------|:--------:|
| maintenance_window | optional sub-block days_of_week (name) | name of the day of the week  | `string` | n/a | No |
| maintenance_window | hours_of_day | The window of hours during the day when maintenance should be performed | `number` | n/a | No |
| maintenance_window | lead_time_in_weeks | lead time window allows user to set a lead time to prepare for a down time | `number` | n/a | no |
| maintenance_window | optional sub-block months (name) | name of the month of the year  | `string` | n/a | no |
| maintenance_window | patching_mode | cloud exadata infrastructure node patching method, either "rolling" or "nonrolling" | `string` | n/a | no |
| maintenance_window | preference | the maintenance window scheduling preference | `string` | n/a | no |
| maintenance_window | weeks_of_month | weeks during the month when maintenance should be performed | `number` | n/a | no |

## Output variables

| Name | Description |
|------|-------------|
| display_name | autonomous vm cluster name|
| id | autonomous vm cluster id |

## Documentation
Oracle Autonomous VM Cluster: <br>
[https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/database_autonomous_vm_cluster](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/database_autonomous_vm_cluster)