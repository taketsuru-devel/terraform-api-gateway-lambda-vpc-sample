

module "vpc" {
  source = "../module/vpc/module"

  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  rtb_cidr = var.rtb_cidr
  subnet_cidr = var.subnet_cidr
  subnet_az = var.subnet_az
}

module "apigw-lambda" {
  source = "../module/apigw-lambda/module"

  project_name = var.project_name
  source_file = var.source_file
  output_path = var.output_path
  lambda_subnet_ids = [module.vpc.subnet_id]
  lambda_security_group_ids = [module.vpc.security_group_id]
  runtime = var.runtime
  handler = var.handler
  addditional_policy_for_lambda_iam = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
}
