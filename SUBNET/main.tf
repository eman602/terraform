resource "aws_subnet" "subnet" {
    availability_zone = var.zone
    availability_zone_id = var.zone_id
    cidr_block = var.v4_cidr
    ipv6_cidr_block = var.v6_cidr
    map_public_ip_on_launch = var.pub_ip
    assign_ipv6_address_on_creation = var.assign_v6
    vpc_id = var.vpc_id
    
    tags = {
        Name = var.tag_name
        Network = var.tag_network
    }
}