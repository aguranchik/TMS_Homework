resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = aws_subnet.public_subnets[0].id
  user_data = templatefile("bastion.sh.tpl", {
    path = join("", ["/home/ec2-user/", var.project_key, ".pem"]),
    key  = tls_private_key.example.private_key_pem
  })
  tags = merge(var.common_tags, { Name = "bastion" })
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.front_sg.id]
  subnet_id              = aws_subnet.public_subnets[0].id
  user_data              = file("web.sh")
  tags                   = merge(var.common_tags, { Name = "web" })
}

resource "aws_instance" "app" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  subnet_id              = aws_subnet.private_subnets[0].id
  user_data              = file("app.sh")
  tags                   = merge(var.common_tags, { Name = "app" })
}

resource "aws_instance" "db" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  subnet_id              = aws_subnet.private_subnets[0].id
  tags                   = merge(var.common_tags, { Name = "db" })
}
