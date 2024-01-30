resource "aws_efs_file_system" "efs" {
  creation_token   = "efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "false"
  tags = {
    Name = "Team1-EFS"
  }
}

resource "aws_efs_mount_target" "efs-mt" {
  count           = var.privateSubnetCount
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.private[count.index].id
  security_groups = [aws_security_group.efs.id]
}
