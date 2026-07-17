# ==========================================
# 1. ROL PARA EC2 / WORKER NODES
# ==========================================
resource "aws_iam_role" "this" {
  name = "${var.role_name}-${var.environment}-reto"
  description = var.role_description
  max_session_duration = var.max_session_duration
  assume_role_policy = var.assume_role_policy
  path = var.path

  tags = var.tags
}

# Políticas nativas indispensables para que los nodos se unan a EKS y expongan logs/red
resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.this.name
}

# Perfil de instancia para cuando usemos EC2 tradicionales
resource "aws_iam_instance_profile" "node_profile" {
  count = var.create_eks_worker_policies ? 1 : 0
  name = "${var.role_name}-profile"
  role = aws_iam_role.this.name
}

# ==========================================
# 2. ROL PARA EL CONTROL PLANE DE EKS (Condicional)
# ==========================================
resource "aws_iam_role" "eks_cluster_role" {
  count = var.create_eks_roles ? 1 : 0
  name  = "${var.role_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSClusterPolicy" {
  count      = var.create_eks_roles ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role[0].name
}