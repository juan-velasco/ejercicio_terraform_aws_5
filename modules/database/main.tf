resource "random_password" "password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "mysql-curso" {
  allocated_storage   = 10
  db_name             = var.db_name
  instance_class      = var.instance_class
  engine              = var.engine
  engine_version      = var.engine_version
  username            = "admin"
  password            = random_password.password.result
  skip_final_snapshot = true
}
