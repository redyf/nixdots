# topology-example.nix
# Simplified Network Topology for Redyf's Infrastructure
# 3-device setup: Desktop, Notebook, and Phone

{ config, ... }:

{
  # ===== NETWORK DEFINITIONS =====

  networks = {
    # Internet Gateway
    internet = {
      name = "Internet";
      cidrv4 = "0.0.0.0/0";
    };

    # Primary LAN Network (Wired)
    lan = {
      name = "Primary LAN";
      cidrv4 = "192.168.1.0/24";
    };

    # Wireless LAN Network
    wlan = {
      name = "Wireless LAN";
      cidrv4 = "192.168.2.0/24";
    };
  };

  # ===== DEVICE DEFINITIONS =====

  nodes = {
    # ===== MAIN DESKTOP =====
    # Role: Workstation & Server
    # This is the main workstation, running NixOS. It provides services to the network.
    desktop = {
      deviceType = "nixos";
      hardware.info = "Desktop - Redyf's Main Workstation";
      interfaces = {
        eth0 = {
          addresses = [ "192.168.1.10/24" ];
          network = "lan";
        };
        wlan0 = {
          addresses = [ "192.168.2.10/24" ];
          network = "wlan";
          type = "wireless";
        };
      };
    };

    # ===== NOTEBOOK =====
    # Role: Personal Laptop
    # A personal laptop for daily use.
    notebook = {
      deviceType = "device";
      hardware.info = "Notebook - Selene's Laptop";
      interfaces = {
        wlan0 = {
          addresses = [ "192.168.2.20/24" ];
          network = "wlan";
          type = "wireless";
        };
        eth0 = {
          addresses = [ "192.168.1.20/24" ];
          network = "lan";
        };
      };
    };

    # ===== PHONE =====
    # Role: Mobile Device
    # A mobile phone.
    phone = {
      deviceType = "device";
      hardware.info = "Phone - Nora's Mobile Device";
      interfaces = {
        wlan0 = {
          addresses = [ "192.168.2.30/24" ];
          network = "wlan";
          type = "wireless";
        };
      };
    };
  };

}

