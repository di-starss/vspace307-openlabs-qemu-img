terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "0.6.11"
    }
  }
}

variable "env" {}
variable "img_source" {}
variable "img_name" {}
variable "img_path" {}

resource "libvirt_pool" "img" {
  name = "img-${var.env}"
  type = "dir"
  path = "${var.img_path}/${var.env}"
}

resource "libvirt_volume" "img" {
  name = "${var.env}-${var.img_name}.qcow2"
  pool = libvirt_pool.img.name
  source = var.img_source
  format = "qcow2"
}

