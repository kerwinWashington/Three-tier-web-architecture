# #db insatnce
# resource "aws_db_instance" "db-instance" {
#   allocated_storage    = 10
#   #db_name              = "mydb"
#   # count = var.privateSubnetCount
#   identifier     = "mydb"
#   engine         = "aurora-mysql"
#   engine_version = "8.0"
#   instance_class = "db.serverless"
#   username       = "admin"
#   password       = "zaQXWER450!"
#   multi_az = true 
#   port = 3306
#   db_subnet_group_name = aws_db_subnet_group.default.name
#   # vpc_security_group_ids = aws_security_group.db-sg.ids
#   # parameter_group_name = "default.aurora-mysql"
#   #skip_final_snapshot  = false
#   tags = {
#     Name = "db-instance"
#   }
# }

# resource "aws_rds_cluster" "aurora-cluster" {
#   cluster_identifier = "mydbcluster"
#   engine             = "aurora-mysql"
#   engine_mode        = "provisioned"
#   engine_version     = "8.0.mysql_aurora.3.04.1"
#   database_name      = "auroracluster"
#   availability_zones = var.AZ
#   # db_cluster_instance_class = "db.t3"
#   allocated_storage = 100
#   # iops = 100
#   storage_type = ""
#   master_username    = "admin"
#   master_password    = "zaQXWER450!"
#   #skip_final_snapshot  = false
#   # serverlessv2_scaling_configuration {
#   #   max_capacity = 1.0
#   #   min_capacity = 0.5
#   # }
# }
# resource "aws_rds_cluster_instance" "cluster-instance" {
#   cluster_identifier = aws_rds_cluster.aurora-cluster.id
#   instance_class     = "db.serverless"
#   engine             = aws_rds_cluster.aurora-cluster.engine
#   engine_version     = aws_rds_cluster.aurora-cluster.engine_version
#   #multi_az           = true
# }

# resource "aws_dynamodb_table" "basic-dynamodb-table" {
#   name           = "Team1-DynamoDB"
#   billing_mode   = "PROVISIONED"
#   read_capacity  = 1
#   write_capacity = 1
#   hash_key       = "title"
#   range_key      = "director"

#   attribute {
#     name = "title"
#     type = "S"
#   }

#   attribute {
#     name = "director"
#     type = "S"
#   }

#   ttl {
#     attribute_name = "TimeToExist"
#     enabled        = false
#   }

# #   global_secondary_index {
# #     name               = "GameTitleIndex"
# #     hash_key           = "GameTitle"
# #     range_key          = "TopScore"
# #     write_capacity     = 10
# #     read_capacity      = 10
# #     projection_type    = "INCLUDE"
# #     non_key_attributes = ["UserId"]
# #   }

#   tags = {
#     Name        = "Team1-dynamodb-table-1"
#   }
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
# resource "aws_rds_cluster" "aurora-cluster" {
#   cluster_identifier = "aurora-cluster"
#   engine             = "aurora-mysql"
#   engine_mode        = "provisioned"
#   engine_version     = "8.0.mysql_aurora.3.02.0"
#   database_name      = "auroracluster"
#   master_username    = "admin"
#   master_password    = "zaQXWER450!"
#   #skip_final_snapshot  = false
#   serverlessv2_scaling_configuration {
#     max_capacity = 1.0
#     min_capacity = 0.5
#   }
# }
# resource "aws_rds_cluster_instance" "cluster-instance" {
#   cluster_identifier = aws_rds_cluster.aurora-cluster.id
#   instance_class     = "db.serverless"
#   engine             = aws_rds_cluster.aurora-cluster.engine
#   engine_version     = aws_rds_cluster.aurora-cluster.engine_version
#   #multi_az           = true
# }