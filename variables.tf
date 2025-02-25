variable "instance_config" {
  type = object({
    instance_name = string
    instance_type = string
    environment   = string
  })
  description = "Instance configuration"

  validation {
    condition     = length(var.instance_config.instance_name) > 5 && length(var.instance_config.instance_name) < 20
    error_message = "The character length of the instance name should be between 5 and 20"
  }

  validation {
    condition     = contains(["t2.micro", "t3.micro", "t2.medium", "t3.medium"], var.instance_config.instance_type)
    error_message = "The allowed instance types are t2.micro and t3.micro and t2.medium and t3.medium"
  }

  validation {
    condition     = contains(["dev", "staging", "prod"], var.instance_config.environment)
    error_message = "The allowed environments are dev and staging and prod"
  }
}

variable "create_instances" {
  type        = bool
  description = "Whether to create instances or not"
  default     = true
}

variable "instance_count" {
  type        = number
  description = "Number of instances to create"
  validation {
    condition     = var.instance_count > 0 && var.instance_count < 10
    error_message = "The instance count should be between 1 and 10"
  }
}

variable "rds_storage_size" {
  type        = number
  description = "The size of the RDS storage"
  default     = 10
  validation {
    condition     = var.rds_storage_size >= 10 && var.rds_storage_size <= 100
    error_message = "The RDS storage size should be between 10 and 100"
  }
}

variable "rds_storage_type" {
  type        = string
  description = "The type of the RDS storage"
  default     = "gp2"
  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2"], var.rds_storage_type)
    error_message = "The allowed RDS storage types are gp2 and gp3 and io1 and io2"
  }
}

variable "rds_instance_class" {
  type        = string
  description = "The instance class of the RDS"
  validation {
    condition     = contains(["db.t3.micro", "db.t4g.micro"], var.rds_instance_class)
    error_message = "The allowed RDS instance classes are db.t3.micro and db.t4g.micro"
  }
}

variable "rds_db_name" {
  type        = string
  description = "The name of the RDS database"
  validation {
    condition     = length(var.rds_db_name) >= 4 && length(var.rds_db_name) < 15
    error_message = "The character length of the RDS database name should be between 4 and 15"
  }
}

variable "rds_db_username" {
  type        = string
  description = "The username of the RDS database"
  validation {
    condition     = length(var.rds_db_username) >= 4 && length(var.rds_db_username) < 12
    error_message = "The character length of the RDS database username should be between 4 and 12"
  }
}

variable "rds_db_password" {
  type        = string
  description = "The password of the RDS database"
  sensitive   = true
  validation {
    condition     = length(var.rds_db_password) >= 8 && length(var.rds_db_password) < 20
    error_message = "The character length of the RDS database password should be between 8 and 20"
  }
}