output "db_instance_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_address" {
  description = "RDS address"
  value       = aws_db_instance.this.address
}

output "db_instance_port" {
  description = "RDS port"
  value       = aws_db_instance.this.port
}

output "db_security_group_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds.id
}
