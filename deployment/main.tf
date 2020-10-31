terraform {
  backend "s3" {
    bucket = "terraform-tfstate-s3"
    region = "ap-northeast-1"
    key = "api-gateway-lambda-vpc"
  }
}

provider "aws" {
  region = "ap-northeast-1"
  profile = "default"
}

module "api-gateway-lambda-vpc" {
  source = "../module/"

  project_name = "tf-api-gateway-lambda-with-vpc"
  vpc_peering_id = "vpc-190dc57d"
  
  source_file = "src/index.py"
  output_path = "dist/lambda.zip"
  runtime = "python3.6"
  handler = "index.lambda_handler"

  vpc_cidr = "10.0.16.0/20"
  rtb_cidr = "10.0.48.0/20"
  subnet_cidr = "10.0.17.0/24"
  subnet_az = "ap-northeast-1a"
}
