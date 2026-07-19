output "bucket_name" {
  value       = aws_s3_bucket.this.bucket
  description = "Nombre del bucket S3"
  
}

output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "ARN del bucket S3"
  
}

output "bucket_domain_name" {
  value       = aws_s3_bucket.this.bucket_domain_name
  description = "Nombre de dominio del bucket S3"
  
}
