resource "aws_db_subnet_group" "db-subnet_group" {
    name = "main"
    subnet_ids  = [var.db_subnet_id]

    tags = {
        Name = var.tag_name
    }
}


resource "aws-db-instance" "rds-instance" {
    allocated_storage = var.storage
    storage_type         = var.storage_type
    engine               = var.engine
    engine_version       = var.engine_version
    instance_class       = var.instance_class
    name                 = var.instance_name
    username             = var.username
    password             = var.password
    db_subnet_group_name = var.db_subnet_id
    vpc_security_group_ids = [var.vps_sg_id]
}