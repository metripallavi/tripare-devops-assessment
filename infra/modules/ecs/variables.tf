variable "project_name" {
  description = "Project name used for tagging AWS resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ECS resources will be deployed."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the Application Load Balancer."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks."
  type        = list(string)
}

variable "container_image" {
  description = "Docker image for the ECS application."
  type        = string
}

variable "container_port" {
  description = "Container port exposed by the application."
  type        = number
}

variable "cpu" {
  description = "CPU units for the ECS task."
  type        = number
}

variable "memory" {
  description = "Memory (MiB) for the ECS task."
  type        = number
}
