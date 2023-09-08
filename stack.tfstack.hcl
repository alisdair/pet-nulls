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

provider "null" "main" {}

provider "random" "main" {}

component "uuid" {
  source = "Invicton-Labs/uuid/random"
  version = "0.2.0"
}

component "pet" {
  source = "./pet"
  inputs = {
    prefix = "${component.uuid.uuid}-${var.prefix}"
  }
  providers = {
    random = provider.random.main
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
