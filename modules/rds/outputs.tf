output "db_host" {
    value = aws_db_instance.postgresdb.address
    description = "Host of the RDS database"
    sensitive   = false
}

output "db_endpoint" {
  description = "Endpoint of the RDS database"
  value       = aws_db_instance.postgresdb.endpoint
  sensitive   = false
}
