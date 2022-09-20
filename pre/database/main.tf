terraform {

  # No se permiten variables en la configuración del backend (se debe copiar tal cual)
  # ¡IMPORTANTE! La key debe cambiar para cada módulo o sobreescribirá otro estado provocando un error.
  backend "s3" {
    bucket         = "curso-terraform-state"
    dynamodb_table = "curso-terraform-locks"
    encrypt        = true
    key            = "ejercicio_terraform_aws_5/pre/database/terraform.tfstate"
    profile        = "juanvelascoaws"
    region         = "eu-west-3"
  }
}

# -----------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "juanvelascoaws"
  region  = "eu-west-3"
}

module "database" {
  source = "../../modules/database/"

  instance_class = var.instance_class
  engine         = var.engine
  engine_version = var.engine_version
  db_name        = var.db_name
}
