terraform {
  backend "s3" {
    bucket = "denn-jenkins"
    region = "us-east-1"
    key    = "dennis-backend/terraform.tfstate"
  }
}