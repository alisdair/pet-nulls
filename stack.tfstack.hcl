required_providers {
  null = {
    source  = "hashicorp/null"
    version = "~> 3.1"
  }

  random = {
    source  = "hashicorp/random"
    version = "~> 3.3"
  }

  external {
    source  = "hashicorp/external"
    version = "~> 2.3"
  }
}

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

provider "null" "main" {}

provider "random" "main" {}

provider "external" "main" {}

component "pet" {
  source = "./pet"
  inputs = {
    prefix = var.prefix
  }
  providers = {
    random   = provider.random.main
    external = provider.external.main
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
