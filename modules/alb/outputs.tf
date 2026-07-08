output "alb_arn" {
  value       = aws_lb.this.arn
  description = "ARN del Application Load Balancer"
}

output "alb_dns_name" {
  value       = aws_lb.this.dns_name
  description = "URL publica del Balanceador de Carga"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "ID del Security Group del ALB para usarlo en las reglas del EC2"
}

output "http_listener_arn" {
  value       = aws_lb_listener.http.arn
  description = "ARN del listener HTTP para añadir reglas de enrutamiento dinámicas"
}