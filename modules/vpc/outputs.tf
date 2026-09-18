output "vpc_id" {
  value = aws_vpc.customer_vpc_Cliff.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.subnet_3.id,
    aws_subnet.subnet_4.id
  ]
}

output "ec2_security_group_id" {
  value = aws_security_group.ec2SG.id
}

output "alb_security_group_id" {
  value = aws_security_group.albSG.id
}

# =========================
# ALB OUTPUTS
# =========================

output "target_group_arn" {
  description = "ARN of the ALB target group"
  value       = aws_lb_target_group.web_tg.arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app_alb.dns_name
}