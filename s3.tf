resource "aws_s3_bucket" "lab_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "lab_bucket_acl" {
  bucket = aws_s3_bucket.lab_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "lab_bucket_policy" {
  bucket = aws_s3_bucket.lab_bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.bucket_name}/*"
    }
  ]
}
POLICY
}

# -------------------------------
# Outputs S3
# -------------------------------
output "bucket_id" {
  value = aws_s3_bucket.lab_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.lab_bucket.arn
}
