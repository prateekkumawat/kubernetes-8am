data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.env
    project     = var.project
  }
}


resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.example.bucket

  rule {
    id = "log"

    expiration {
      days = 90
    }

    filter {
      and {
        prefix = "log/"

        tags = {
          rule      = "log"
          autoclean = "true"
        }
      }
    }

    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }

  rule {
    id = "tmp"

    filter {
      prefix = "tmp/"
    }

    expiration {
      date = "2023-01-13T00:00:00Z"
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket" "logging" {
  bucket = "hsit-tf-access-logging-bucket"
}

data "aws_iam_policy_document" "logging_bucket_policy" {
  statement {
    principals {
      identifiers = ["logging.s3.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.logging.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.example.bucket

  target_bucket = aws_s3_bucket.logging.bucket
  target_prefix = "log/"
  target_object_key_format {
    partitioned_prefix {
      partition_date_source = "EventTime"
    }
  }
}

resource "aws_s3_bucket_policy" "logging" {
  bucket = aws_s3_bucket.logging.bucket
  policy = data.aws_iam_policy_document.logging_bucket_policy.json
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# resource "aws_s3_bucket_policy" "websitepolicy" {
#   bucket = aws_s3_bucket.example.id
#   policy = data.aws_iam_policy_document.webpolicy.json
# }

# data "aws_iam_policy_document" "webpolicy" {
#   statement {
#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:PutObject",
#       "s3:ListBucket",
#     ]

#     resources = [
#       aws_s3_bucket.example.arn,
#       "${aws_s3_bucket.example.arn}/*",
#     ]
#   }
# }

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.example.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          AWS = "arn:aws:iam::605134434853:user/prateek"
        }

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]

        Resource = "${aws_s3_bucket.example.arn}/*"
      }
    ]
  })
}