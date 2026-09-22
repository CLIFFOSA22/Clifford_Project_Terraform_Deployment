# =========================
# EXISTING S3 BUCKET. USING DATASOURCE TO REFERENCE IT
# =========================

data "aws_s3_bucket" "terraform_state" {
  bucket = "today14-2026"
}