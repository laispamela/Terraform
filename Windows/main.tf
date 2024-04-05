terraform {
  required_version = ">= 1.7.0" # Obrigatorio estar com a versão 1.6.0 ou superior

  #Escolher o provedor - AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.42.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" #Definir Região
  shared_config_files = ["C:/Users/14275239407/.aws/config"] 
  shared_credentials_files = ["C:/Users/14275239407/.aws/credentials"] #Definir ID conta e Key

  default_tags {
    tags = {
      owner      = "Lais"
      managed-by = "Terraform134"
    }
  }
}