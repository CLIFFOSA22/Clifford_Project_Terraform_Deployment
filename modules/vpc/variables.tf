variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Enter VPC CIDR"
}

variable "subnet_cidr_block_1" {
  type        = string
  default     = "10.0.1.0/24"
  description = "Enter subnet-1 CIDR"
}

variable "subnet_cidr_block_2" {
  type        = string
  default     = "10.0.2.0/24"
  description = "Enter subnet-2 CIDR"
}

variable "subnet_cidr_block_3" {
  type        = string
  default     = "10.0.3.0/24"
  description = "Enter subnet-3 CIDR"
}

variable "subnet_cidr_block_4" {
  type        = string
  default     = "10.0.4.0/24"
  description = "Enter subnet-4 CIDR"
}

variable "az1" {
  type        = string
  default     = "ca-central-1a"
  description = "Enter AZ 1"
}

variable "az2" {
  type        = string
  default     = "ca-central-1b"
  description = "Enter AZ 2"
}

variable "aws_route_table" {
  type        = string
  default     = "0.0.0.0/0"
  description = "Public route destination"
}

variable "aws_security_group" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "Allowed CIDR blocks"
}