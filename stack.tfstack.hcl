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

component "nulls" {
  source = "./nulls"
  inputs = {
    pet       = component.pet.name
    instances = var.instances
  }
  providers = {
    null = provider.null.main
  }
}

component "slow" {
  source = "./slow"
  inputs = {
    duration = 10
    multiple = 3
  }
  providers = {
    http      = provider.http.main
    random    = provider.random.main
    terraform = provider.terraform.main
  }
}
