data "aws_availability_zones" "options" {
    state = "available"
}

variable "zone" {
    description = "Available Zones to assign the VPC's Subnet."
    type = string
    default = data.aws_availability_zones.options.names[0]
}

variable "zone_id" {
    description = "Based on the zone selected this is to be the ID related to it."
}

variable "v4_cidr" {
    description = "This is the v4 Cider Block. This has the first 3 Blocks locked."
}

variable "v6_cidr" {
    description = "Request a v6_cidr for the given Subnet."
}

variable "pub_ip" {
    description = "Request a public ID for the given Subnet."
}

variable "assign_v6" {
    description = "Provide this a v6 cidr IP."
}

variable "vpc_id" {
    description = "This uses the VPC id aquired from the VPC Module to map this Subnet to the correct Network."
}

variable "tag_name" {
    description = "This is the name of this Subnet"
}

variable "tag_network" {
    description = "This is Network for this Subnet"
}