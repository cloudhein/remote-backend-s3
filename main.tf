data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "default_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  count = var.create_instances ? var.instance_count : 0

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = local.instance_type
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id              = element(data.aws_subnets.default_vpc_subnets.ids, count.index) # create instances in different subnets

  tags = {
    Name        = "${local.instance_name}-${count.index + 1}"
    Environment = local.environment
  }
}

# Create a Security Group to allow SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default_vpc.id

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_rules" {
  security_group_id = aws_security_group.allow_ssh.id

  cidr_ipv4   = local.anywhere
  from_port   = local.ssh_port
  ip_protocol = local.tcp_protocol
  to_port     = local.ssh_port
}

resource "aws_vpc_security_group_ingress_rule" "allow_icmp_rules" {
  security_group_id = aws_security_group.allow_ssh.id

  cidr_ipv4   = local.anywhere
  from_port   = local.all_protocols_ports
  ip_protocol = local.icmp_protocol
  to_port     = local.all_protocols_ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = local.all_protocols_ports # semantically equivalent to all ports
}