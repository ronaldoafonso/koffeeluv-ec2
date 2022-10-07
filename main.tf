
resource "aws_instance" "instances" {
  for_each               = var.instances
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  key_name               = each.value.key_name
  subnet_id              = var.subnets[each.value.subnet].id
  vpc_security_group_ids = [for security_group in each.value.security_groups: var.security_groups[security_group].id]

  tags = {
    Name        = each.value.name
    Environment = var.environment
  }
}

resource "aws_lb" "lb" {
  name               = var.lb.name
  internal           = var.lb.internal
  load_balancer_type = var.lb.load_balancer_type
  security_groups    = var.lb.security_group_ids
  subnets            = var.lb.subnet_ids

  tags = {
    Name        = var.lb.name
    Environment = var.environment
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.lb.listener.port
  protocol          = var.lb.listener.protocol

  default_action {
    type             = var.lb.listener.default_action.type
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = var.lb.target_group.name
  port        = var.lb.target_group.port
  protocol    = var.lb.target_group.protocol
  vpc_id      = var.lb.target_group.vpc_id
}

resource "aws_autoscaling_attachment" "autoscaling_attachment" {
  autoscaling_group_name = var.lb.autoscaling_group.id
  lb_target_group_arn   = aws_lb_target_group.lb_target_group.arn
}
