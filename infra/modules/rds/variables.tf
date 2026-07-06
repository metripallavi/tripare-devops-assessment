variable "project_name" {
  description = "Project name used for tagging AWS resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for RDS."
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID of the ECS service."
  type        = string
}

variable "db_name" {
  description = "Database name."
  type        = string
}

variable "db_username" {
  description = "Database master username."
  type        = string
}

variable "db_password" {
  description = "Database master password."
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GB."
  type        = number
}

variable "backup_retention_period" {
  description = "Backup retention period."
  type        = number
}

variable "deletion_protection" {
  description = "Enable deletion protection."
  type        = bool
}
