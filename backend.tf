terraform {
  backend "s3" {
    bucket         = "remote-state-bucket-dev-007"
    key            = "terraform/s3-remote-state/files"
    encrypt        = true
    dynamodb_table = "dynamodb-state-locking-table"
    region         = "ap-northeast-1"
    profile        = "terraform-dev-role"
  }
}
