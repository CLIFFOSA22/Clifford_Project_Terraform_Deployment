# =========================
# KMS KEY
# =========================

resource "aws_kms_key" "cliff_kms_key" {
  description             = var.kms_description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation

  tags = {
    Name = "cliff-project-kms-key"
  }
}


# =========================
# KMS ALIAS
# =========================

resource "aws_kms_alias" "cliff_kms_alias" {
  name          = var.kms_alias
  target_key_id = aws_kms_key.cliff_kms_key.key_id
}