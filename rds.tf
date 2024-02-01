# create serverless aurora
resource "aws_rds_cluster" "auroracluster" {
  cluster_identifier     = "auroracluster"
  engine                 = "aurora-mysql"
  engine_mode            = "provisioned"
  engine_version         = "8.0.mysql_aurora.3.02.0"
  database_name          = "team1db"
  master_username        = "admin"
  master_password        = "zaQXWER450!"
  db_subnet_group_name   = aws_db_subnet_group.default.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.lb-sg.id]
  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
  tags = {
    Name = "Team1-RDS"
  }
}
resource "aws_rds_cluster_instance" "cluster-instance" {
  cluster_identifier  = aws_rds_cluster.auroracluster.id
  instance_class      = "db.serverless"
  engine              = aws_rds_cluster.auroracluster.engine
  engine_version      = aws_rds_cluster.auroracluster.engine_version
  publicly_accessible = false
  promotion_tier      = 1
  availability_zone   = "us-east-1b"
}

resource "aws_rds_cluster_instance" "writer-instance" {
  cluster_identifier  = aws_rds_cluster.auroracluster.id
  instance_class      = "db.serverless"
  engine              = aws_rds_cluster.auroracluster.engine
  engine_version      = aws_rds_cluster.auroracluster.engine_version
  publicly_accessible = false
  promotion_tier      = 1
  availability_zone   = "us-east-1b"
}

resource "aws_db_subnet_group" "default" {
  name  = "aurorasubnetgroupteamone"
  # count = var.privateSubnetCount
  #   vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.db_subnet[0].id, aws_subnet.db_subnet[1].id]

  tags = {
    Name = "My DB subnet group"
  }
}