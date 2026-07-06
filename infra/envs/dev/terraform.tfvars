aws_region = "ap-south-1"

project_name = "tripare-devops-assessment"
environment  = "dev"

vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

container_image = "nginx:latest"
container_port  = 80

cpu    = 256
memory = 512

db_name     = "hoteldb"
db_username = "postgres"
db_password = "Password@123"

instance_class = "db.t3.micro"

allocated_storage = 20

backup_retention_period = 3

deletion_protection = false
