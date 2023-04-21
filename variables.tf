variable "aws_region" {
  description = "AWS region"
  default     = "us-east-2"
  type        = string
}

variable "aws_availability_zones" {
  description = "a comma-separated list of availability zones"
  default     = {
    "us-east-2a" = ["192.168.0.0/19", "192.168.96.0/19"]
    "us-east-2b" = ["192.168.32.0/19", "192.168.128.0/19"]
    "us-east-2c" = ["192.168.64.0/19", "192.168.160.0/19"]
  }
  type        = map
}

variable "aws_cidr_block" {
  description = "cidr block"
  default     = "192.168.0.0/16"
  type        = string
}