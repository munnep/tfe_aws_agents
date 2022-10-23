resource "aws_launch_configuration" "agent" {
  count                = var.agent_token == "" ? 0 : 1
  name_prefix          = "${var.tag_prefix}-agent"
  image_id             = var.ami
  instance_type        = "t3.small"
  security_groups      = [aws_security_group.default-sg.id]
  iam_instance_profile = aws_iam_instance_profile.profile.name
  key_name             = "${var.tag_prefix}-key"

  root_block_device {
    volume_size = 20

  }

  user_data = templatefile("${path.module}/scripts/cloudinit_tfe_agent.yaml", {
    tag_prefix   = var.tag_prefix
    dns_hostname = var.dns_hostname
    dns_zonename = var.dns_zonename
    agent_token  = var.agent_token
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg_agent" {
  count                = var.agent_token == "" ? 0 : 1
  name                 = "${var.tag_prefix}-asg-agent"
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  desired_capacity     = var.asg_desired_capacity
  force_delete         = true
  launch_configuration = aws_launch_configuration.agent[0].name
  vpc_zone_identifier  = [aws_subnet.private1.id]

  tag {
    key                 = "Name"
    value               = "${var.tag_prefix}-asg-agent"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}