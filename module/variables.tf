# general
variable "project_name" {
  description = "to name of resource"
}

# peering vpc id
variable "vpc_peering_id" {
  description = "vpc id of peering"
}

# for apigw-lambda
variable "source_file" {
  description = "source path of lambda, single file"
}

variable "output_path" {
  description = "output path and filename of code of lambda, must be .zip"
}

variable "runtime" {
  description = "runtime name, e.g. python3.6"
}

variable "handler" {
  description = "entrypoint of source code, e.g. index.lambda_handler"
}

# for vpc
variable "vpc_cidr" {
  description = "cidr of vpc, ex: 10.0.0.0/20"
}

variable "rtb_cidr" {
  description = "cidr of rtb, must not be belong to vpc_cidr, ex: 10.0.16.0/20"
}

variable "subnet_cidr" {
  description = "cidr of subnet, must be belong to vpc_cidr, ex: 10.0.0.0/24"
}

variable "subnet_az" {
  description = "az of subnet, ex: ap-northeast-1a"
}
