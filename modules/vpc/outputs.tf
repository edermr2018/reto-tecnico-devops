# -----------------------------------------------------------------------------
# VPC
# -----------------------------------------------------------------------------
output "vpc_id" {
  description = "ID del VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "CIDR block del VPC"
  value       = aws_vpc.this.cidr_block
}

# -----------------------------------------------------------------------------
# SUBNETS
# -----------------------------------------------------------------------------
output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  description = "IDs de las subnets de base de datos"
  value       = aws_subnet.database[*].id
}

# -----------------------------------------------------------------------------
# NETWORKING
# -----------------------------------------------------------------------------
output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = try(aws_internet_gateway.this[0].id, null)
}

output "nat_gateway_id" {
  description = "ID del NAT Gateway (null si enable_nat_gateway = false)"
  value       = try(aws_nat_gateway.this[0].id, null)
}

output "nat_gateway_public_ip" {
  description = "IP pública del NAT Gateway (null si enable_nat_gateway = false)"
  value       = try(aws_eip.nat[0].public_ip, null)
}

output "public_route_table_id" {
  description = "ID de la route table pública"
  value       = try(aws_route_table.public[0].id, null)
}

output "private_route_table_id" {
  description = "ID de la route table privada"
  value       = try(aws_route_table.private[0].id, null)
}

output "database_route_table_id" {
  description = "ID de la route table de base de datos"
  value       = try(aws_route_table.database[0].id, null)
}

# -----------------------------------------------------------------------------
# COSTOS ESTIMADOS (rápido de mostrar en entrevista)
# -----------------------------------------------------------------------------
output "estimated_nat_monthly_cost_usd" {
  description = "Costo mensual estimado del NAT Gateway (hora + EIP, sin tráfico procesado)"
  value       = var.enable_nat_gateway ? "~$32.85/mes (NAT: $32.4 + EIP: $0.45)" : "$0 (NAT deshabilitado)"
}