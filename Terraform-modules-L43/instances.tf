resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = module.network.public_subnets[0].id
  user_data = templatefile("bastion.sh.tpl", {
    path = join("", ["/home/ec2-user/", var.project_key, ".pem"]),
    key  = tls_private_key.example.private_key_pem
  })
  tags = merge(var.common_tags, { Name = "bastion" })
}

resource "aws_instance" "web" {
  count                  = module.network.az_count
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.front_sg.id]
  subnet_id              = module.network.public_subnets[count.index].id
  user_data              = file("web.sh")
  tags                   = merge(var.common_tags, { Name = "web ${count.index + 1}" })
}

resource "aws_instance" "app" {
  count                  = module.network.az_count
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.app_sg[count.index].id]
  subnet_id              = module.network.private_subnets[count.index].id
  user_data              = file("app.sh")
  tags                   = merge(var.common_tags, { Name = "app ${count.index + 1}" })
}

resource "aws_instance" "db" {
  count                  = module.network.az_count
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.db_sg[count.index].id]
  subnet_id              = module.network.private_subnets[count.index].id
  tags                   = merge(var.common_tags, { Name = "db ${count.index + 1}" })
}
