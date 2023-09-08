terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
}

module "uuid" {
  source  = "Invicton-Labs/uuid/random"
  version = "0.2.0"
}

variable "prefix" {
  type = string
}

resource "random_pet" "this" {
  prefix = "${module.uuid.uuid}-${var.prefix}"
  length = 3
}

output "name" {
  value = random_pet.this.id
}
