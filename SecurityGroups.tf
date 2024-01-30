### Load Balancer Security Group ###
resource "aws_security_group" "lb-sg" {
  name        = "Team1-asg-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Team1-lb-sg"
  }
}

### Auto Scaling Group Security Group ### #wordpress SG
resource "aws_security_group" "asg-sg" {
  name        = "Team1-asg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id
  depends_on = [aws_security_group.lb-sg]
  ingress {
    description     = "TLS from VPC"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.lb-sg.id]
  }
  ingress {
    description     = "HTTP from VPC"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Team1-ASG-SG"
  }
}

### Elastic File System Security Group ###
resource "aws_security_group" "efs" {
  name        = "Team1-EFS"
  description = "Allow only EC2"
  vpc_id      = aws_vpc.main.id
  depends_on = [aws_security_group.lb-sg, aws_security_group.asg-sg]
  ingress {
    description     = "TCP on 2409"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.asg-sg.id] # wordpress sg
  }
  ingress {
    description     = "HTTP from VPC"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Team1-EFS-SG"
  }
}

### Database Security Group ###
resource "aws_security_group" "db-sg" {
  name        = "Team1-db-sg"
  description = "Allow ASG inbound traffic"
  vpc_id      = aws_vpc.main.id
  depends_on = [aws_security_group.asg-sg]
  ingress {
    description     = "DB from ASG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.asg-sg.id] #wordpress SG
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Team1-DB-SG"
  }
}

