output "kms_key_id" {
  description = "ID of the KMS key"
  value       = aws_kms_key.cliff_kms_key.key_id
}

output "kms_key_arn" {
  description = "ARN of the KMS key"
  value       = aws_kms_key.cliff_kms_key.arn
}