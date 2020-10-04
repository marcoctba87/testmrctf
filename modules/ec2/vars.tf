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

variable "default_tags" {
  type = map(string)
}

variable "sg_alb_cidr_blocks" {
  type = list(string)
}

variable "subnet_a_id" {
  type = string
}

variable "subnet_b_id" {
  type = string
}