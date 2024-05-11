variable "DATABASE_USER" {}
variable "DATABASE_PASSWORD" {}
variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
variable "aws_session_token" {}

provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  token = var.aws_session_token
  region = "us-east-1"
}

resource "aws_db_instance" "goodburguer" {
  identifier           = "goodburguer"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = var.DATABASE_USER
  password             = var.DATABASE_PASSWORD
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
