output "address" {
  value = aws_db_instance.mysql-curso.address
}

output "username" {
  value = aws_db_instance.mysql-curso.username
}

output "password" {
  value     = random_password.password.result
  sensitive = true
}
