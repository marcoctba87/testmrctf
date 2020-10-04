# Variaveis do modulo

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "cidr_block_a" {
  type = string
}

variable "cidr_block_b" {
  type = string
}

variable "default_tags" {
  type = map(string)
}