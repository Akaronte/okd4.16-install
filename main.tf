terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc8"
    }
  }
  required_version = ">= 1.2.0"
}

# Configure the Proxmox provider
provider "proxmox" {
  pm_api_url = "https://192.168.1.5:8006/api2/json"
  pm_user = "root@pam"
  pm_password = "mondariz10"
  pm_tls_insecure = true
}

# #terraform apply destroy -target=proxmox_vm_qemu.bootstrap
resource "proxmox_vm_qemu" "bootstrap" {
  target_node = "makinon"
  name        = "bootstrap"
  pxe         = true
  agent       = 0
  vmid        = 103


  network {
    id     = 0   
    model  = "e1000"
    bridge = "vmbr1"
    macaddr = "BC:24:11:2C:4B:35"
  }

  memory      = 16384
  cores       = 2
  sockets     = 2
  

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/bootstrap.iso"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = "64G"
          storage = "NV1000"
        }
      }
    }
  }

  bios = "ovmf"
  boot = "order=virtio0;ide2;net0;"
  
  scsihw = "virtio-scsi-pci"
}


# # #terraform apply destroy -target=proxmox_vm_qemu.master1
resource "proxmox_vm_qemu" "master1" {
  target_node = "makinon"
  name        = "master1"
  pxe         = true
  agent       = 0
  vmid        = 104

  network {
    id     = 0   
    model  = "e1000"
    bridge = "vmbr1"
    macaddr = "BC:24:11:55:E0:79"
  }

  memory      = 32768
  cores       = 4
  sockets     = 4

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/master.iso"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = "128G"
          storage = "NV1000"
        }
      }
    }
  }

  bios = "ovmf"
  boot = "order=virtio0;ide2;net0;"
  
  scsihw = "virtio-scsi-pci" 
  

}

# # #terraform apply destroy -target=proxmox_vm_qemu.master2
resource "proxmox_vm_qemu" "master2" {
  target_node = "makinon"
  name        = "master2"
  pxe         = true
  agent       = 0
  vmid        = 105

  network {
    id     = 0   
    model  = "e1000"
    bridge = "vmbr1"
    macaddr = "BC:24:11:F5:80:16"
  }

  memory      = 32768
  cores       = 4
  sockets     = 4

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/master.iso"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = "128G"
          storage = "NV1000"
        }
      }
    }
  }

  bios = "ovmf"
  boot = "order=virtio0;ide2;net0;"
  
  scsihw = "virtio-scsi-pci" 

}

# terraform apply destroy -target=proxmox_vm_qemu.master3
resource "proxmox_vm_qemu" "master3" {
  target_node = "makinon"
  name        = "master3"
  pxe         = true
  agent       = 0
  vmid        = 106 

  network {
    id     = 0   
    model  = "e1000"
    bridge = "vmbr1"
    macaddr = "BC:24:11:5C:D8:B3"
  }

  memory      = 32768
  cores       = 4
  sockets     = 4

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/master.iso"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = "128G"
          storage = "NV1000"
        }
      }
    }
  }

  bios = "ovmf"
  boot = "order=virtio0;ide2;net0;"
  
  scsihw = "virtio-scsi-pci" 

}


# terraform apply destroy -target=proxmox_vm_qemu.worker1
resource "proxmox_vm_qemu" "worker1" {
  target_node = "makinon"
  name        = "worker1"
  pxe         = true
  agent       = 0
  vmid        = 107

  network {
    id     = 0   
    model  = "e1000"
    bridge = "vmbr1"
    macaddr = "BC:24:11:96:EF:CA"
  }

  memory      = 32768
  cores       = 4
  sockets     = 4

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/worker.iso"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = "256G"
          storage = "TERA2"
        }
      }
    }
  }

  bios = "ovmf"
  boot = "order=virtio0;ide2;net0;"
  
  scsihw = "virtio-scsi-pci" 

}


# terraform apply destroy -target=proxmox_vm_qemu.worker2
resource "proxmox_vm_qemu" "worker2" {
  target_node = "makinon"
  name        = "worker2"
  pxe         = true
  agent       = 0
  vmid        = 108

  network {
    id     = 0   
    model  = "e1000"
    bridge = "vmbr1"
    macaddr = "BC:24:11:45:49:6E"
  }

  memory      = 32768
  cores       = 4
  sockets     = 4

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/worker.iso"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = "256G"
          storage = "TERA2"
        }
      }
    }
  }

  bios = "ovmf"
  boot = "order=virtio0;ide2;net0;"
  
  scsihw = "virtio-scsi-pci" 

}


# terraform apply destroy -target=proxmox_vm_qemu.worker3
resource "proxmox_vm_qemu" "worker3" {
  target_node = "makinon"
  name        = "worker3"
  pxe         = true
  agent       = 0
  vmid        = 109

  network {
    id     = 0   
    model  = "e1000"
    bridge = "vmbr1"
    macaddr = "BC:24:11:BB:A4:8C"
  }

  memory      = 32768
  cores       = 4
  sockets     = 4

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/worker.iso"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = "256G"
          storage = "TERA2"
        }
      }
    }
  }

  bios = "ovmf"
  boot = "order=virtio0;ide2;net0;"
  
  scsihw = "virtio-scsi-pci" 

}


# terraform apply destroy -target=proxmox_vm_qemu.worker4
resource "proxmox_vm_qemu" "worker4" {
  target_node = "makinon"
  name        = "worker4"
  pxe         = true
  agent       = 0
  vmid        = 110

  network {
    id     = 0   
    model  = "e1000"
    bridge = "vmbr1"
    macaddr = "BC:24:11:33:03:BE"
  }

  memory      = 32768
  cores       = 4
  sockets     = 4

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/worker.iso"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = "256G"
          storage = "TERA2"
        }
      }
    }
  }

  bios = "ovmf"
  boot = "order=virtio0;ide2;net0;"
  
  scsihw = "virtio-scsi-pci" 

}



#BC:24:11:2C:4B:35

#BC:24:11:55:E0:79
#BC:24:11:F5:80:16
#BC:24:11:5C:D8:B3

#BC:24:11:96:EF:CA
#BC:24:11:45:49:6E
#BC:24:11:BB:A4:8C
#BC:24:11:33:03:BE
