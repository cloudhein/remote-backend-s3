variable "instance_name" {
  type        = string
  description = "Name of the EC2 instances"
  validation {
    condition     = length(var.instance_name) > 5 && length(var.instance_name) < 15
    error_message = "The character length of the instance name should be between 5 and 15"
  }
}

variable "instance_type" {
  type        = string
  description = "Type of the allowed EC2 instances"
  validation {
    condition     = contains(["t2.micro", "t3.micro", "t2.medium", "t3.medium"], var.instance_type)
    error_message = "The allowed instance types are t2.micro and t3.micro and t2.medium and t3.medium"
  }  
}
