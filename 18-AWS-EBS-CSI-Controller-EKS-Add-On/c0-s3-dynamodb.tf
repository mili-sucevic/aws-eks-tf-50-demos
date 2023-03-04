# S3 Buckets
resource "aws_s3_bucket" "dev-bucket" {
  bucket = "msj-terraform-on-aws-eks"
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
  key     = "/dev/ebs-addon/"
  content = ""
}

resource "aws_s3_bucket_object" "dev-bucket-sub4" {
  bucket  = aws_s3_bucket.dev-bucket.id
  key     = "/dev/ebs-storage/"
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

resource "aws_dynamodb_table" "dev-app1-k8s" {
  name           = "dev-eks-addon"
  read_capacity  = 5
  write_capacity = 5

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "dev-eks-irsa-demo" {
  name           = "dev-ebs-storage"
  read_capacity  = 5
  write_capacity = 5

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}