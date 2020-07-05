resource "aws_route_table_association" "table_association" {
  vpc_id         = var.vpc_id
  route_table_id = var.table_id
}