required_providers {
  random = {
    source  = "hashicorp/random"
    version = "~> 3.3"
  }
}

variable "prefix" {
  type = string
}

provider "random" "main" {}

component "pet" {
  source = "./pet"
  inputs = {
    prefix = var.prefix
  }
  providers = {
    random   = provider.random.main
  }
}
