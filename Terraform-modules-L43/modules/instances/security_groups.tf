resource "aws_security_group" "bastion_sg" {
  vpc_id = module.network.vpc_id

  ingress {
    description = "SSH allow to bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "bastion_sg-${var.common_tags.Environment}" })
}

resource "aws_security_group" "front_sg" {
  vpc_id = module.network.vpc_id
  #  depends_on = [aws_vpc.main]

  ingress {
    description = "HTTP allow to front"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS allow to front"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH allow to front"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.bastion.private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "front_sg-${var.common_tags.Environment}" })
}

resource "aws_security_group" "app_sg" {
  count  = module.network.az_count
  vpc_id = module.network.vpc_id
  #  depends_on = [aws_vpc.main]

  ingress {
    description = "HTTP allow to front"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.web[count.index].private_ip}/32"]
  }

  ingress {
    description = "SSH allow to app"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.bastion.private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "app_sg-${var.common_tags.Environment}-${count.index + 1}" })
}

resource "aws_security_group" "db_sg" {
  count  = module.network.az_count
  vpc_id = module.network.vpc_id
  #  depends_on = [aws_vpc.main]

  ingress {
    description = "5432 allow to db"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.app[count.index].private_ip}/32"]
  }

  ingress {
    description = "SSH allow to front"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.bastion.private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "db_sg-${var.common_tags.Environment}-${count.index + 1}" })
}