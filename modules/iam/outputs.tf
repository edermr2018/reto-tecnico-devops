output "node_role_arn" {
  value       = aws_iam_role.this.arn
  description = "ARN del rol para las instancias EC2 o Nodos de EKS"
}

output "instance_profile_name" {
  value       = var.create_eks_worker_policies ? aws_iam_instance_profile.node_profile[0].name : null
  description = "Nombre del Instance Profile para EC2"
}

output "eks_cluster_role_arn" {
  value       = var.create_eks_cluster_role ? aws_iam_role.eks_cluster_role[0].arn : null
  description = "ARN del rol del cluster EKS"
}