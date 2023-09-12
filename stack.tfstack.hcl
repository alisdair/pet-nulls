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

component "pet" {
  source = "./pet"
  inputs = {
    prefix = var.prefix
  }
  providers = {
    random   = provider.random.main
  }
}

component "another_pet" {
  source = "./pet"
  inputs = {
    prefix = var.prefix
  }
  providers = {
    random   = provider.random.main
  }
}

component "third_pet" {
  source = "./pet"
  inputs = {
    prefix = var.prefix
  }
  providers = {
    random   = provider.random.main
  }
}

component "pet_pet" {
  source = "./pet"
  inputs = {
    prefix = component.third_pet.name
  }
  providers = {
    random   = provider.random.main
  }
}

component "pet_pet_pet" {
  source = "./pet"
  inputs = {
    prefix = component.pet_pet.name
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

component "more_nulls" {
  source = "./nulls"
  inputs = {
    pet       = component.another_pet.name
    instances = var.instances
  }
  providers = {
    null = provider.null.main
  }
}

component "double_pet_nulls" {
  source = "./nulls"
  inputs = {
    pet       = component.pet_pet.name
    instances = var.instances
  }
  providers = {
    null = provider.null.main
  }
}
