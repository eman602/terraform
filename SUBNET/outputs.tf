output "sub_id" {
    value = "${aws_subnet.Pub-Sub-Net.id}"
}

output "sub_arn" {
    value = "${aws_subnet.Pub-Sub-Net.arn}"
}

output "sub_v6" {
    value = "${aws_subnet.Pub-Sub-Net.ipv6_cidr_block_association_id}"
}

output "sub_owner" {
    value = "${aws_subnet.Pub-Sub-Net.owner_id}"
}