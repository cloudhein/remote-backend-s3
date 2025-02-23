variable "instance_name" {
  type        = string
  description = "Name of the EC2 instances"
  validation {
    condition     = length(var.instance_name) > 5 && length(var.instance_name) < 15
    error_message = "The character length of the instance name should be between 5 and 15"
  }
}