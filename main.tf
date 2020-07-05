provider "aws" {
    version = "~> 2.8"
    region = "eu-west-1"
    sharied_credentials_file = "/home/ubuntu/.aws/credentials"
}

resource "aws_key_pair" "key_pair" {
    key_name = "${pem-keyname}"
    public_key = "${pem-keypub}"
}

module "vpc" {
    source = "./VPC"
    v4_cidr = "126.156.0.0/16"
    dns_host = true

    # @@@ TAGS @@@
    name_tag = "PetClinic"
}

module "igw" {
    source = "./IGW"
    vpc_id = module.vpc.vpc_id

    # @@@ TAGS @@@
    igw_name = "PetClinic_igw"
    igw_network = "Network_Gate"
}

module "public_subnet" {
    source = "./SUBNET"
    v4_cidr = "126.156.245.0/24"
    pub_ip = true
    vpc_id = module.vpc.vpc_id

    # @@@ TAGS @@@
    tag_name = "Public_Subnet"
    tag_network = "Public"
}

# VPC Required
module "public_routes" {
    source = "./ROUTES"
    vpc_id = module.vpc.vpc_id
    v4_cidr = "0.0.0.0/0"
    igw_id = module.igw.igw_id

    # @@@ TAGS @@@
    tag_name = "Public-Routes"
    tag_network = "Public"

}

module "public_routes_association" {
    source = "./ROUTES/ASSOCIATION"
    vpc_id = module.vpc.vpc_id
    route_table_id = module.public-routes.route_id
}

module "sg" {
    source = "./SG"
    sg_description = "This Security Group is created to allow various port access to an instance."
    vpc_id = module.vpc.vpc_id
    port_desc = ["HTTP-port", "HTTPS-port", "Flask-port", "Java-port"] # Default = ["HTTP-port", "HTTPS-port"]
    in_port = [80, 443, 5000, 8080] # Default = [80, 443]
    in_cidr = "0.0.0.0/0"
    out_port = 0
    out_protocol = "-1"
    out_cidr = "0.0.0.0/0"
    
    # @@@ TAGS @@@
    tag_name = "multi_port_access"
}

module "mysql_rds" {
    source = "./RDS"
    name = "petclinic"
    instance_class = "t2.micro"
    vpc_sg_id = module.sg.sg_id
    db_subnet_id = module.public_subnet.sub_id
    username = "${username}"
    password = "${password}"

    # @@@ TAGS @@@
    tag_name = "My DB subnet group"
}

module "ec2_manager" {
    source = "./EC2"
    ami_code = "ami-008320af74136c628" # Ubuntu 16.04
    type_code = "t3a.medium" # 2 x CPU + 4 x RAM
    pem_key = "${pem-keyname}"
    subnet = module.public_subnet.sub_id
    vpc_sg = module.sg.sg_id
    pub_ip = true

    # @@@ TAGS @@@
    tag_name = "Kube-Manager"
}

module "ec2_worker1" {
    source = "./EC2"
    ami_code = "ami-008320af74136c628" # Ubuntu 16.04
    type_code = "t2.micro" # 2 x CPU + 4 x RAM
    pem_key = "${pem-keyname}"
    subnet = module.public_subnet.sub_id
    vpc_sg = module.sg.sg_id
    pub_ip = true

    # @@@ TAGS @@@
    tag_name = "Kube-Worker1"
}

module "ec2_worker2" {
    source = "./EC2"
    ami_code = "ami-008320af74136c628" # Ubuntu 16.04
    type_code = "t2.micro" # 2 x CPU + 4 x RAM
    pem_key = "${pem-keyname}"
    subnet = module.public_subnet.sub_id
    vpc_sg = module.sg.sg_id
    pub_ip = true # default = false

    # @@@ TAGS @@@
    tag_name = "Kube-Worker2"
}