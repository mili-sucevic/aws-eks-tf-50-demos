# S3 Buckets
resource "aws_s3_bucket" "dev-bucket" {
  bucket = "msf-terraform-on-aws-eks"
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
