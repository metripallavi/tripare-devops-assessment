output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = module.ecs.alb_dns_name
}

output "ecs_cluster_id" {
  description = "ECS Cluster ID"
  value       = module.ecs.ecs_cluster_id
}

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = module.rds.db_instance_endpoint
}

output "rds_address" {
  description = "RDS Address"
  value       = module.rds.db_instance_address
}
