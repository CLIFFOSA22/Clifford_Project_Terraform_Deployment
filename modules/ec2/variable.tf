variable "ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the EC2 instance"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for the EC2 instance"
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the ALB target group"
}