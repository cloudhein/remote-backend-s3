locals {
  instance_type = var.instance_config.instance_type
  instance_name = var.instance_config.instance_name
  environment   = var.instance_config.environment
}

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

  ami             = data.aws_ami.ubuntu.id
  instance_type   = local.instance_type
  security_groups = [aws_security_group.allow_ssh.name]
  subnet_id       = element(data.aws_subnets.default_vpc_subnets.ids, count.index) # create instances in different subnets

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

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress rule for ICMP (ping)
  ingress {
    description = "ICMP from anywhere"
    from_port   = -1 # ICMP doesn’t use ports, -1 is used
    to_port     = -1 # ICMP doesn’t use ports, -1 is used
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}