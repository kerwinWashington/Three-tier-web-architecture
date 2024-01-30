### Launch Template ###
resource "aws_launch_template" "asg-lt" {
  iam_instance_profile {
    arn = "arn:aws:iam::782863115905:instance-profile/S3-role" 
  }
  image_id = "ami-008677ef1baf82eaf"
  instance_type = "t3.medium"
  key_name = "kwashington-kp"
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "enabled"
  }
  monitoring {
    enabled = true
  }
  vpc_security_group_ids = [aws_security_group.asg-sg.id]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Team1-LT"
    }
  }
  user_data = filebase64("${path.module}/wordpress.sh")
}
