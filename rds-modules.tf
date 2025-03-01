module "rds" {
  source             = "./modules/rds"
  rds_storage_size   = var.rds_storage_size
  rds_storage_type   = var.rds_storage_type
  rds_instance_class = var.rds_instance_class

  rds_db_name     = var.rds_db_name
  rds_db_username = var.rds_db_username
  rds_db_password = var.rds_db_password

  vpc_id            = data.aws_vpc.default_vpc.id
  security_group_id = aws_security_group.ec2_sg.id
}