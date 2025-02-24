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