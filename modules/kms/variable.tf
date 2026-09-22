variable "kms_description" {
  type        = string
  description = "Description of the KMS key"
  default     = "KMS key for Clifford DevOps project"
}

variable "deletion_window_in_days" {
  type        = number
  description = "Number of days before the KMS key is deleted"
  default     = 7
}

variable "enable_key_rotation" {
  type        = bool
  description = "Enable automatic KMS key rotation"
  default     = true
}

variable "kms_alias" {
  type        = string
  description = "Alias name for the KMS key"
  default     = "alias/cliff-project-key"
}