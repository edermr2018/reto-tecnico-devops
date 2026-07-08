# Security Group para el ALB: Permite tráfico web desde cualquier parte del mundo
resource "aws_security_group" "alb" {
  name        = "${var.environment}-alb-sg"
  description = "Permite trafico HTTP entrante para el ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP desde Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Trafico saliente ilimitado"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.environment}-alb-sg" })
}

# El Application Load Balancer
resource "aws_lb" "this" {
  name               = "${var.environment}-main-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = merge(var.tags, { Name = "${var.environment}-alb" })
}

# Listener HTTP por defecto (Retorna un 404 fijo hasta que le peguemos el EC2 o EKS)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Solucion Base - ALB Operacional (Lite-Thinking)"
      status_code  = "200"
    }
  }
}