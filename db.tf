variable "DATABASE_USER" {}
variable "DATABASE_PASSWORD" {}

provider "aws" {
  region = "us-east-1"  # Substitua pela sua região desejada
}

resource "aws_db_instance" "goodburguer" {
  identifier           = "goodburguer"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = var.database_user
  password             = var.database_password
  parameter_group_name = "default.mysql5.7"

  publicly_accessible  = true 

  # Adiciona o grupo de segurança
  vpc_security_group_ids = [aws_security_group.goodburguerdb_security_group.id]
}

resource "aws_security_group" "goodburguerdb_security_group" {
  name        = "goodburguerdb_security_group"
  description = "Permite trafego de entrada para o banco de dados RDS"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  #
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
