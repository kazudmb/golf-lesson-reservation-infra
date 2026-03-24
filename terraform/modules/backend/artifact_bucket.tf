resource "aws_s3_bucket" "artifact" {
  count  = var.create_artifact_bucket ? 1 : 0
  bucket = var.artifact_bucket_name

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name      = var.artifact_bucket_name
    Project   = var.project
    ManagedBy = "terraform"
    Purpose   = "backend-artifacts"
  }
}

resource "aws_s3_bucket_versioning" "artifact" {
  count  = var.create_artifact_bucket ? 1 : 0
  bucket = aws_s3_bucket.artifact[0].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "artifact" {
  count  = var.create_artifact_bucket ? 1 : 0
  bucket = aws_s3_bucket.artifact[0].bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "artifact" {
  count  = var.create_artifact_bucket ? 1 : 0
  bucket = aws_s3_bucket.artifact[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
