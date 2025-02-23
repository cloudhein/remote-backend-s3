output "vpc_id" {
  description = "ID of default VPC"
  value       = data.aws_vpc.default_vpc.id
  sensitive = false
}

output "subnet_ids" {
  description = "IDs of default VPC subnets"
  value       = data.aws_subnets.default_vpc_subnets.ids
  sensitive = false
}

