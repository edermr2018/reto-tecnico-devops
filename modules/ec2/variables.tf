variable "ami" {
  description = "The AMI ID to use for the instance"
  type        = string
  
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
}

variable "force_destroy" {
  description = "Whether to force destroy the instance"
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to use"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use"
  type        = string
}

variable "public_key" {
  description = "The public key to use for the key pair"
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in"
  type        = string
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = ""
}

variable "volume_type" {
  description = "The type of volume to use for the root block device"
  type        = string
  default     = "gp3"
}

variable "volume_size" {
  description = "The size of the volume to use for the root block device"
  type        = number
  default     = 8
}

variable "delete_on_termination" {
  description = "Whether to delete the root block device on instance termination"
  type        = bool
  default     = true
}

variable "encrypted" {
  description = "Whether to encrypt the root block device"
  type        = bool
  default     = false
}
