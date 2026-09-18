# =========================
# APPLICATION LOAD BALANCER
# =========================

resource "aws_lb" "app_alb" {
  name               = "cliff-app-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.albSG.id
  ]

  subnets = [
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id
  ]

  tags = {
    Name = "cliff-app-alb"
  }
}


# =========================
# TARGET GROUP
# =========================

resource "aws_lb_target_group" "web_tg" {
  name     = "cliff-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.customer_vpc_Cliff.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name = "cliff-web-tg"
  }
}


# =========================
# ALB LISTENER
# =========================

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}