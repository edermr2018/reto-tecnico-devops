variable "bucket_name" {
    description = "The name of the S3 bucket"
    type        = string    
}

variable "tags" {
    description = "A map of tags to assign to the bucket"
    type        = map(string)
    default     = {}
}

variable "force_destroy" {
    description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
    type        = bool
}

variable "acl" {
    description = "The ACL to apply to the S3 bucket"
    type        = string
}

variable "enable_versioning" {
    description = "A boolean that indicates whether versioning should be enabled for the S3 bucket"
    type        = bool
}

variable "encryption_algorithm" {
    description = "The algorithm to use for server-side encryption"
    type        = string
}

variable "block_public_policy" {
    description = "A boolean that indicates whether to block public bucket policies"
    type        = bool
    default     = true
}

variable "ignore_public_acls" {
    description = "A boolean that indicates whether to ignore public ACLs"
    type        = bool
    default     = true
}

variable "restrict_public_buckets" {
    description = "A boolean that indicates whether to restrict public bucket access"
    type        = bool
    default     = true
}

variable "ignore_public_acls" {
    description = "A boolean that indicates whether to ignore public ACLs"
    type        = bool
    default     = true
}

variable "restrict_public_buckets" {
    description = "A boolean that indicates whether to restrict public bucket access"
    type        = bool
    default     = true
}


variable "owner_controls" {
    description = "A string that indicates the object ownership setting for the S3 bucket"
    type        = string
    default     = ""
}
variable "enable_versioning" {
    description = "A boolean that indicates whether versioning should be enabled for the S3 bucket"
    type        = bool
    default     = false
}

variable "bucket_policy" {
    description = "A JSON string that represents the bucket policy to apply to the S3 bucket"
    type        = string
    default     = ""
}
