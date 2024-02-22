resource "aws_s3_bucket" "example" {
  bucket = "${var.prefix}-${var.repository_name}-${var.image_version}"
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket,
    aws_s3_bucket_public_access_block.bucket,
  ]

  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"
}

output "s3_bucket_uri" {
  value = aws_s3_bucket.bucket.bucket
}