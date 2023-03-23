# S3 Buckets
resource "aws_s3_bucket" "dev-bucket" {
  bucket = "msq-terraform-on-aws-eks"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "dev-bucket-sub1" {
  bucket  = aws_s3_bucket.dev-bucket.id
  key     = "dev/"
  content = ""
}

resource "aws_s3_bucket_object" "dev-bucket-sub2" {
  bucket  = aws_s3_bucket.dev-bucket.id
  key     = "/dev/eks-cluster/"
  content = ""
}

resource "aws_s3_bucket_object" "dev-bucket-sub3" {
  bucket  = aws_s3_bucket.dev-bucket.id
  key     = "/dev/aws-lbc/"
  content = ""
}

resource "aws_s3_bucket_object" "dev-bucket-sub4" {
  bucket  = aws_s3_bucket.dev-bucket.id
  key     = "/dev/aws-external-dns/"
  content = ""
}

resource "aws_s3_bucket_object" "dev-bucket-sub5" {
  bucket  = aws_s3_bucket.dev-bucket.id
  key     = "/dev/aws-lbc-ingress/"
  content = ""
}

# DynamoDB
resource "aws_dynamodb_table" "dev-eks-cluster" {
  name           = "dev-eks-cluster"
  read_capacity  = 5
  write_capacity = 5

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "dev-aws-lbc" {
  name           = "dev-aws-lbc"
  read_capacity  = 5
  write_capacity = 5

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "dev-aws-external-dns" {
  name           = "dev-aws-external-dns"
  read_capacity  = 5
  write_capacity = 5

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "dev-aws-lbc-ingress" {
  name           = "aws-lbc-ingress"
  read_capacity  = 5
  write_capacity = 5

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}