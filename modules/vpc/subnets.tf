# -----------------------------------------------------------------------------
# PÚBLICAS
# -----------------------------------------------------------------------------
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-public-${var.azs[count.index]}"
      Tier = "Public"
    },
  )
}

# -----------------------------------------------------------------------------
# PRIVADAS (si se define eks_cluster_name, se taguean para EKS aquí mismo)
# -----------------------------------------------------------------------------
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-private-${var.azs[count.index]}"
      Tier = "Private"
    },
    var.eks_cluster_name != "" ? {
      "kubernetes.io/role/internal-elb"        = "1"
      "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    } : {},
  )
}

# -----------------------------------------------------------------------------
# BASE DE DATOS (opcional, aisladas por defecto)
# -----------------------------------------------------------------------------
resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.database_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-database-${var.azs[count.index]}"
      Tier = "Database"
    },
  )
}