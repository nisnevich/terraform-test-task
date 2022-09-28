terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }  
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.aws_region
}

resource "aws_instance" "app_server" {
  ami           = var.image_id
  instance_type = "t2.micro"

  tags = {
    Name = var.project_name
  }
}

module "eswap-ecr" {
  source = "./ecr"
}

module "s3" {
  source = "./ci_cd/s3-bucket"
}

module "deploy-ecr" {
  source = "./ci_cd/deploy-ecr"
}

module "deploy-eks" {
  source = "./ci_cd/deploy-eks"
}

