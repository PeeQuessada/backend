resource "aws_s3_bucket" "s3bucket" {
  bucket = "${var.prefix}-${var.repository_name}-${var.image_version}"
}

resource "aws_s3_bucket_ownership_controls" "s3bucket" {
  bucket = aws_s3_bucket.s3bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "s3bucket" {
  bucket = aws_s3_bucket.s3bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "s3bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.s3bucket,
    aws_s3_bucket_public_access_block.s3bucket,
  ]

  bucket = aws_s3_bucket.s3bucket.id
  acl    = "public-read"
}

output "s3_bucket_uri" {
  value = aws_s3_bucket.s3bucket.bucket
}