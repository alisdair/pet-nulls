terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
}

variable "prefix" {
  type = string
}

resource "random_pet" "this" {
  prefix = var.prefix
  length = 3
}

output "name" {
  value = random_pet.this.id
}

resource "random_pet" "additional" {
  prefix = var.prefix
  length = 5
}
