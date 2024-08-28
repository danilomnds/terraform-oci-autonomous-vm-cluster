variable "autonomous_data_storage_size_in_tbs" {
  type    = number
  default = null
}

variable "compartment_id" {
  type = string
}

variable "compute_model" {
  type    = string
  default = "ECPU"
}

variable "cpu_core_count_per_node" {
  type    = number
  default = null
}

variable "db_servers" {
  type    = list(string)
  default = null
}

variable "defined_tags" {
  type    = map(string)
  default = null
}

variable "display_name" {
  type = string
}

variable "exadata_infrastructure_id" {
  type = string
}

variable "freeform_tags" {
  type    = map(string)
  default = null
}

variable "is_local_backup_enabled" {
  type    = bool
  default = null
}

variable "is_mtls_enabled" {
  type    = bool
  default = null
}

variable "license_model" {
  type    = string
  default = "BRING_YOUR_OWN_LICENSE"
}

variable "maintenance_window_details" {
  type = object({
    days_of_week = optional(object({
      name = string
    }))
    hours_of_day       = optional(number)
    lead_time_in_weeks = optional(number)
    months = optional(object({
      name = string
    }))
    patching_mode  = optional(string)
    preference     = optional(string)
    weeks_of_month = optional(string)
  })
  default = null
}

variable "memory_per_oracle_compute_unit_in_gbs" {
  type    = number
  default = null
}

variable "scan_listener_port_non_tls" {
  type    = number
  default = null
}

variable "scan_listener_port_tls" {
  type    = number
  default = null
}

variable "time_zone" {
  type    = string
  default = null
}

variable "total_container_databases" {
  type    = number
  default = null
}

variable "vm_cluster_network_id" {
  type    = string
  default = null
}

variable "groups" {
  type    = list(string)
  default = null
}

variable "compartment" {
  type    = string
  default = null
}

variable "enable_group_access" {
  type    = bool
  default = true
}