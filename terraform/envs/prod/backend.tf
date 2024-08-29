terraform {
  backend "s3" {
    bucket = "barkuni-tf-state"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}
