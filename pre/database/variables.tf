variable "instance_class" {
  description = "Instance class"
  default     = "db.t3.micro"
}

variable "engine" {
  description = "Database Engine"
  default     = "mysql"
}

variable "engine_version" {
  description = "Database Engine Version"
  default     = "5.7"
}

variable "db_name" {
  description = "Database Name"
  default     = "cursoaws"
}
