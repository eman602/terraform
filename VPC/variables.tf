variable "v4_cidr" {
    description = "This is the base CIDR Block for this Instance. the first 2 Blacks are locked."
}

variable "int_tena" {
    description = "Create an instance with 'Default' or 'Dedicated' Tenancy Settings."
}

variable "dns_supp" {
    description = "Enable or Disable DNS Support."
}

variable "dns_host" {
    description = "Enable or Disable DNS Host Support."
}

variable "class" {
    description = "Enable or Disable Classlink. Only valid in some regions."
}

variable "class_dns_supp" {
    description = "Enable or Disable Classlink Support. Only valid in some regions."
}

variable "v6_cidr" {
    description = "'Request' or 'Reject' v6 CIDR Block."
}

variable "name_tag" {
    description = "The Name the Instance will hold on AWS"
}