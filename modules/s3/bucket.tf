resource "aws_s3_bucket" "this" {
    bucket = var.bucket_name
    force_destroy = var.force_destroy

    tags = merge(var.tags, {
        "Name" = var.bucket_name
        "Module" = "s3"
        "ManagedBy" = "Terraform"
    })
}

resource "aws_s3_bucket_acl" "this" {
    count = var.acl == "private" ? 1 : 0
    depends_on = [aws_s3_bucket_owner_controls.this]
    bucket = aws_s3_bucket.this.id
    acl    = var.acl
  
}

resource "aws_s3_bucket_owner_controls" "this" {
    count = var.owner_controls != "" ? 1 : 0
    bucket = aws_s3_bucket.this.id
    rule {
        object_ownership = var.owner_controls
    }
}

resource "aws_s3_bucket_versioning" "this" {
    count = var.enable_versioning == true ? 1 : 0
    bucket = aws_s3_bucket.this.id
    versioning_configuration {
        status = var.enable_versioning
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
    bucket = aws_s3_bucket.this.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = var.encryption_algorithm
        }
    }
}

resource "aws_s3_bucket_policy" "this" {
    bucket = aws_s3_bucket.this.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = "*"
                Action = "s3:GetObject"
                Resource = "${aws_s3_bucket.this.arn}/*"
            }
        ]
    })
}

resource "aws_s3_bucket_public_access_block" "this" {
    bucket = aws_s3_bucket.this.id
    block_public_acls       = var.block_public_policy
    ignore_public_acls      = var.ignore_public_acls
    restrict_public_buckets = var.restrict_public_buckets
    block_public_policy     = var.block_public_policy
}