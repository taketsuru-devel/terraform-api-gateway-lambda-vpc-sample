# exist data source
data "aws_vpc" "ec2_vpc" {
  id = var.vpc_peering_id
}

# lambda to ec2
resource "aws_vpc_peering_connection" "this_to_ec2" {
  peer_vpc_id = module.vpc.vpc_id
  vpc_id = data.aws_vpc.ec2_vpc.id
  auto_accept = true
  tags = {
    Name = format("%s-vpc-peering", var.project_name)
  }
}

