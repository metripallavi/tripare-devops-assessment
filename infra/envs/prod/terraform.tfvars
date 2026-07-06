aws_region = "ap-south-1"

project_name = "tripare-devops-assessment"
environment  = "prod"

vpc_cidr = "10.1.0.0/16"

public_subnet_cidrs = [
  "10.1.1.0/24",
  "10.1.2.0/24"
]

private_subnet_cidrs = [
  "10.1.11.0/24",
  "10.1.12.0/24"
]

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

container_image = "nginx:latest"
container_port  = 80

cpu    = 512
memory = 1024

db_name     = "hoteldb"
db_username = "postgres"
db_password = "Password@123"

instance_class = "db.t3.small"

allocated_storage = 50

backup_retention_period = 14

deletion_protection = true