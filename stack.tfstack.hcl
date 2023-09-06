required_providers {
  null = {
    source  = "hashicorp/null"
    version = "~> 3.1"
  }

  random = {
    source  = "hashicorp/random"
    version = "~> 3.3"
  }
}

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

component "pet" {
  source = "./pet"
  inputs = {
    prefix = var.prefix
  }
}

component "nulls" {
  source = "./nulls"
  inputs = {
    pet       = component.pet.name
    instances = var.instances
  }
}
