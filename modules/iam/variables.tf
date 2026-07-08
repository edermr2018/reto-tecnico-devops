variable "environment" {
  type        = string
  description = "Entorno de despliegue (ej. stage, prod)"
}

variable "role_name" {
  type        = string
  description = "Nombre del rol IAM para las instancias EC2 o Nodos de EC2"
} 

variable "role_description" {
  type        = string
}

variable "max_session_duration" {
  type        = number
  default     = 3600
  description = "Duración máxima de la sesión en segundos para el rol IAM"
}

variable "path" {
  description = "Path for the IAM role"
  type        = string
  default     = "/"

}

variable "assume_role_policy" {
  type        = string
  description = "Política de asunción de rol para el rol IAM"
}

variable "create_eks_roles" {
  type        = bool
  default     = false
  description = "Flag para habilitar la creación de roles para EKS"
}

variable "tags" {
  type        = map(string)
  default     = {}
}