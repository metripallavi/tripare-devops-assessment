variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
}

variable "container_image" {
  description = "Docker image"
  type        = string
}

variable "container_port" {
  description = "Application port"
  type        = number
}

variable "cpu" {
  description = "Fargate CPU"
  type        = number
}

variable "memory" {
  description = "Fargate Memory"
  type        = number
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage"
  type        = number
}

variable "backup_retention_period" {
  description = "Backup retention"
  type        = number
}

variable "deletion_protection" {
  description = "Deletion protection"
  type        = bool
}
