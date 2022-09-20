terraform {

  # No se permiten variables en la configuración del backend (se debe copiar tal cual)
  # ¡IMPORTANTE! La key debe cambiar para cada módulo o sobreescribirá otro estado provocando un error.
  backend "s3" {
    bucket         = "curso-terraform-state"
    dynamodb_table = "curso-terraform-locks"
    encrypt        = true
    key            = "ejercicio_terraform_aws_5/pre/webserver/terraform.tfstate"
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

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    # Con esta configuración, junto con el "most_recent", siempre usaremos la última imagen generada.
    values = ["app-symfony-packer-aws-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["545663651640"] # juanvelasco
}

data "terraform_remote_state" "database" {
  backend = "s3"

  config = {
    bucket  = "curso-terraform-state"
    key     = "ejercicio_terraform_aws_5/pre/database/terraform.tfstate"
    region  = "eu-west-3"
    profile = "juanvelascoaws"
  }
}

module "webserver" {
  source = "../../modules/webserver/"

  instance_type     = var.instance_type
  key_pair_name     = var.key_pair_name
  ami_id            = data.aws_ami.ubuntu.id
  database_address  = data.terraform_remote_state.database.outputs.address
  database_username = data.terraform_remote_state.database.outputs.username
  database_password = data.terraform_remote_state.database.outputs.password
}
