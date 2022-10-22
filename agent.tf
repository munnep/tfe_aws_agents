resource "aws_launch_configuration" "agent" {
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