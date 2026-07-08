# -----------------------------------------------------------------------------
# GENERAL
# -----------------------------------------------------------------------------
variable "name" {
  description = "Nombre base del VPC, usado como prefijo en todos los recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser: dev, staging o prod."
  }
}

variable "tags" {
  description = "Tags comunes aplicados a todos los recursos del módulo"
  type        = map(string)
  default     = {}
}

# -----------------------------------------------------------------------------
# VPC
# -----------------------------------------------------------------------------
variable "vpc_cidr_block" {
  description = "CIDR block del VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Habilita DNS hostnames en el VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilita soporte DNS en el VPC"
  type        = bool
  default     = true
}

# -----------------------------------------------------------------------------
# SUBNETS
# -----------------------------------------------------------------------------
variable "azs" {
  description = "Zonas de disponibilidad a usar, ej: [\"us-east-1a\", \"us-east-1b\"]"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs de subnets públicas (una por AZ, en el mismo orden que var.azs)"
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "CIDRs de subnets privadas (una por AZ, en el mismo orden que var.azs)"
  type        = list(string)
  default     = []
}

variable "database_subnet_cidrs" {
  description = "CIDRs de subnets de base de datos, sin salida a internet (opcional)"
  type        = list(string)
  default     = []
}

# -----------------------------------------------------------------------------
# EKS (opcional) — en vez de un tier de subnets aparte, taguea las privadas
# -----------------------------------------------------------------------------
variable "eks_cluster_name" {
  description = "Si se define, taguea las subnets privadas para auto-discovery de EKS (kubernetes.io/cluster/<name>=shared)"
  type        = string
  default     = ""
}

# -----------------------------------------------------------------------------
# NAT GATEWAY
# -----------------------------------------------------------------------------
variable "enable_nat_gateway" {
  description = "Crea un NAT Gateway único para dar salida a internet a las subnets privadas. Apágalo en dev si no lo necesitas (ahorra ~$32/mes + tráfico)."
  type        = bool
  default     = false
}

variable "enable_database_nat_gateway" {
  description = "Permite que las subnets de base de datos también salgan a internet vía el NAT Gateway. Por defecto quedan aisladas (recomendado)."
  type        = bool
  default     = false
}