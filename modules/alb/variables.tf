variable "environment" {
  type        = string
  description = "Nombre del entorno (ej. stage, prod)"
}

variable "vpc_id" {
  type        = string
  description = "ID de la VPC donde se desplegará el ALB"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Lista de IDs de subnets públicas (mínimo 2 en distintas AZs)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags comunes para los recursos"
}