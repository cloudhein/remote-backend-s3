output "vpc_id" {
  description = "ID of default VPC"
  value       = data.aws_vpc.default_vpc.id
  sensitive   = false
}

output "subnet_ids" {
  description = "IDs of default VPC subnets"
  value       = data.aws_subnets.default_vpc_subnets.ids
  sensitive   = false
}

output "public_ip" {
  description = "Public IP addresses of the instances"
  value       = aws_instance.web[*].public_ip
  sensitive   = false
}

output "db_endpoint" {
  description = "Endpoint of the RDS database"
  value       = aws_db_instance.postgresdb.endpoint
  sensitive   = false
}

output "db_host" {
  description = "Host of the RDS database"
  value       = aws_db_instance.postgresdb.address
  sensitive   = false
}

output "db_port" {
  description = "Port of the RDS database"
  value       = aws_db_instance.postgresdb.port
  sensitive   = false
}
