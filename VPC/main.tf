resource "aws_vpc" "VPC" {
    cidr_block = var.v4_cidr
    Instance_tenancy = var.int_tena
    enable_dns_support = var.dns_supp
    enable_dns_hostnames = var.dns_host
    enable_classiclink = var.class
    enable_classiclink_dns_support = var.class_dns_supp
    assign_generated_ipv6_cidr_block = var.v6_cidr

    tags = {
        Name = var.tag_name
    }
}