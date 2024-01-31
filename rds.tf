#create serverless aurora
# resource "aws_rds_cluster" "auroracluster" {
#   cluster_identifier = "auroracluster"
#   engine             = "aurora-mysql"
#   engine_mode        = "provisioned"
#   engine_version     = "8.0.mysql_aurora.3.02.0"
#   database_name      = "team1db"
#   master_username    = "admin"
#   master_password    = "zaQXWER450!"
#   db_subnet_group_name = aws_db_subnet_group.default.name
#   skip_final_snapshot  = true
#   vpc_security_group_ids = [aws_security_group.project-2-db-sg.id]
#   serverlessv2_scaling_configuration {
#     max_capacity = 1.0
#     min_capacity = 0.5
#   }
#       tags = {
#         Name = "Team1-RDS"
#       }
# }
# resource "aws_rds_cluster_instance" "cluster-instance" {
#   cluster_identifier = aws_rds_cluster.team4auroracluster.id
#   instance_class     = "db.serverless"
#   engine             = aws_rds_cluster.team4auroracluster.engine
#   engine_version     = aws_rds_cluster.team4auroracluster.engine_version
# }

# #db insatnce
# resource "aws_db_instance" "db-instance" {
#   allocated_storage    = 100
#   #db_name              = "mydb"
#   identifier           = "mydb"
#   engine               = "aurora-mysql"
#   engine_version       = "8.0"
#   instance_class       = "db.serverless"
#   username             = "admin"
#   password             = "zaQXWER450!"
#   db_subnet_group_name = aws_db_subnet_group.default.name
#  # parameter_group_name = "default.aurora-mysql"
#   #skip_final_snapshot  = false
#     tags = {
#     Name = "db-instance"
#   }
# }