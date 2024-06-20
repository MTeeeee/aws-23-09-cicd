resource "aws_s3_bucket" "app_bucket" {
  bucket = "react-app-trololol"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "app_bucket_policy" {
  bucket = aws_s3_bucket.app_bucket.id
  policy = <<POLICY
    {
    "Id": "Policy1718878884886",
    "Version": "2012-10-17",
    "Statement": [
        {
        "Sid": "Stmt1718878883751",
        "Action": [
            "s3:GetObject"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.app_bucket.bucket}/*",
        "Principal": "*"
        }
    ]
    }
  POLICY
}

resource "aws_s3_bucket_public_access_block" "app_bucket" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.app_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

