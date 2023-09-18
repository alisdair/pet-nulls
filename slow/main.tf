terraform {
  required_providers {
    http = {
      source = "hashicorp/http"
      version = "3.4.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.3.2"
    }

    terraform = {
      source = "terraform.io/builtin/terraform"
    }
  }
}

variable "duration" {
  type    = number
  default = 5
}

variable "multiple" {
  type    = number
  default = 1
}

locals {
  duration = terraform_data.duration.input
  first    = terraform_data.first.input.duration
  second   = terraform_data.second.input.duration
  third    = terraform_data.third.input.duration
}

resource "terraform_data" "duration" {
  input = var.duration
}

data "http" "first" {
  url = "https://httpbin.org/delay/${local.duration}?duration=${local.duration}"
}

resource "terraform_data" "first" {
  input = {
    duration = jsondecode(data.http.first.response_body).args.duration
  }
}

data "http" "second" {
  url = "https://httpbin.org/delay/${local.first * var.multiple}?duration=${local.first * var.multiple}"
}

resource "terraform_data" "second" {
  input = {
    duration = jsondecode(data.http.second.response_body).args.duration
  }
}

data "http" "third" {
  url = "https://httpbin.org/delay/${local.second * var.multiple}?duration=${local.second * var.multiple}"
}

resource "terraform_data" "third" {
  input = {
    duration = jsondecode(data.http.third.response_body).args.duration
  }
}

resource "random_pet" "pet" {
  length = local.third
}
