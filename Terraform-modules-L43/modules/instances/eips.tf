
resource "aws_eip" "bastion_eip" {
  instance = aws_instance.bastion.id
  #  associate_with_private_ip = aws_instance.bastion.private_ip
  tags = merge(var.common_tags, { Name = "bastion_eip-${var.common_tags.Environment}" })
}

# resource "aws_eip" "web_eip" {
#   instance = aws_instance.web[0].id
#   #  associate_with_private_ip = aws_instance.bastion.private_ip
#   tags = merge(var.common_tags, { Name = "web_eip-${var.common_tags.Environment}" })
# }