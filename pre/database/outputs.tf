output "address" {
  value = module.database.address
}

output "username" {
  value = module.database.username
}

output "password" {
  value     = module.database.password
  sensitive = true
}
