required_providers {
  http = {
    source = "hashicorp/http"
    version = "3.4.0"
  }

  null = {
    source  = "hashicorp/null"
    version = "~> 3.1"
  }

  random = {
    source  = "hashicorp/random"
    version = "~> 3.3"
  }

  terraform = {
    source = "terraform.io/builtin/terraform"
  }
}

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

provider "http" "main" {}

provider "null" "main" {}

provider "random" "main" {}

provider "terraform" "main" {}

component "pet" {
  source = "./pet"
  inputs = {
    prefix = var.prefix
  }
  providers = {
    random   = provider.random.main
  }
}
