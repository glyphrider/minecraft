terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.2"
    }
    random = {
      source = "hashicorp/random"
      version = "3.0.0"
    }
  }
}

