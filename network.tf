# vpc(isolated) needs...
#  route_table
#  security_group
#  subnet
# optional
#  nat gateway

#tags.Name is used to display console
resource "aws_vpc" "this" {
  cidr_block = "192.168.128.0/20"
  assign_generated_ipv6_cidr_block = "false"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  tags = {
    Name = format("%s-vpc", var.project_name)
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = data.aws_vpc.ec2_vpc.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.this_to_ec2.id
  }
  tags = {
    Name = format("%s-rtb", var.project_name)
  }
}

resource "aws_subnet" "this" {
  vpc_id = aws_vpc.this.id
  cidr_block = "192.168.129.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = format("%s-subnet", var.project_name)
  }
}

#cannot define tags
resource "aws_route_table_association" "this_subnet_assoc" {
  subnet_id = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}

#ingress : inbound
#egress : outbound
#no definition ingress because of isolated

resource "aws_security_group" "this" {
  name = format("%s-sg", var.project_name)
  vpc_id = aws_vpc.this.id
  egress { 
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  description = format("%s-sg", var.project_name)
  tags = {
    Name = format("%s-sg", var.project_name)
  }
}
