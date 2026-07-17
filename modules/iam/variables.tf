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

# -----------------------------------------------------------------------------
# EKS WORKER NODE (opcional) — solo actívalo si este rol es para nodos EC2 de EKS
# -----------------------------------------------------------------------------

variable "create_eks_worker_policies" {
  type        = bool
  default     = false
  description = "Adjunta AmazonEKSWorkerNodePolicy + AmazonEKS_CNI_Policy + AmazonEC2ContainerRegistryReadOnly y crea un Instance Profile. Solo para roles de worker nodes de EKS sobre EC2."
}

# -----------------------------------------------------------------------------
# EKS CLUSTER / CONTROL PLANE (opcional, rol independiente del principal)
# -----------------------------------------------------------------------------

variable "create_eks_cluster_role" {
  type        = bool
  default     = false
  description = "Crea un rol adicional para el control plane de EKS, independiente del rol principal"
}

variable "eks_cluster_role_name" {
  type        = string
  default     = ""
  description = "Nombre del rol del control plane EKS. Si se deja vacío, se usa '<role_name>-eks-cluster'."
}

variable "tags" {
  type        = map(string)
  default     = {}
}