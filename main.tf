
resource "aws_instance" "instances" {
  for_each               = var.instances
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  key_name               = each.value.key_name
  subnet_id              = var.subnets[each.value.subnet].id
  vpc_security_group_ids = concat(
    [for security_group in each.value.security_groups: var.security_groups[security_group].id],
    [var.security_groups["allow_all_outbound_traffic_security_group"].id]
  )

  tags = {
    Name        = each.value.name
    Environment = var.environment
  }
}
