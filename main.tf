resource "oci_database_autonomous_vm_cluster" "autonomous_vm_cluster" {
  autonomous_data_storage_size_in_tbs = var.autonomous_data_storage_size_in_tbs
  compartment_id                      = var.compartment_id
  compute_model                       = var.compute_model
  cpu_core_count_per_node             = var.cpu_core_count_per_node
  db_servers                          = var.db_servers
  defined_tags                        = local.defined_tags
  display_name                        = var.display_name
  exadata_infrastructure_id           = var.exadata_infrastructure_id
  freeform_tags                       = var.freeform_tags
  is_local_backup_enabled             = var.is_local_backup_enabled
  is_mtls_enabled                     = var.is_mtls_enabled
  license_model                       = var.license_model
  dynamic "maintenance_window_details" {
    for_each = var.maintenance_window_details != null ? [var.maintenance_window_details] : []
    content {
      dynamic "days_of_week" {
        for_each = maintenance_window_details.value.days_of_week != null ? [maintenance_window_details.value.days_of_week] : []
        content {
          name = days_of_week.value.name
        }        
      }
      hours_of_day = lookup(maintenance_window_details.value, "hours_of_day", null)
      lead_time_in_weeks = lookup(maintenance_window_details.value, "lead_time_in_weeks", null)
      dynamic "months" {
        for_each = maintenance_window_details.value.months != null ? [maintenance_window_details.value.months] : []
        content {
          name = months.value.name
        }        
      }
      patching_mode = lookup(maintenance_window_details.value, "patching_mode", null)
      preference = lookup(maintenance_window_details.value, "preference", null)
      weeks_of_month = lookup(maintenance_window_details.value, "weeks_of_month", null)
    }
  }
  memory_per_oracle_compute_unit_in_gbs = var.memory_per_oracle_compute_unit_in_gbs
  scan_listener_port_non_tls            = var.scan_listener_port_non_tls
  scan_listener_port_tls                = var.scan_listener_port_tls
  time_zone                             = var.time_zone
  total_container_databases             = var.total_container_databases
  vm_cluster_network_id                 = var.vm_cluster_network_id
  lifecycle {
    ignore_changes = [
      defined_tags["IT.create_date"]
    ]
  }
  timeouts {
    create = "12h"
    delete = "6h"
  }
}

resource "oci_identity_policy" "autonomous_vm_cluster_policy" {
  #if you are deploying the resource outside your home region uncomment the line below
  #provider   = oci.oci-gru
  depends_on = [oci_database_autonomous_vm_cluster.autonomous_vm_cluster]
  for_each = {
    for group in var.groups : group => group
    if var.groups != [] && var.compartment != null
  }
  compartment_id = var.compartment_id
  name           = "policy_${var.display_name}"
  description    = "allow one or more groups to read the autonomous vm cluster"
  statements = [
    "Allow group ${each.value} to read autonomous-vmclusters in compartment ${var.compartment}"
  ]
}