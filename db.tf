# resource "aws_db_instance" "default" {
#   allocated_storage      = 10
#   db_name                = "mydb"
#   engine                 = "aurora-mysql"
#   engine_version         = "5.7"
#   instance_class         = "db.t3.medium"
#   username               = "foo"
#   password               = "foobarbaz"
#   parameter_group_name   = "default.mysql5.7"
#   skip_final_snapshot    = true
#   availability_zone      = "us-east-1a"
#   port                   = 3306
#   vpc_security_group_ids = [aws_security_group.db-sg.id]
#   multi_az = true
#   db_subnet_group_name  =  aws_subnet.db_subnet[0].name
# }

# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#vpc_security_group_ids
