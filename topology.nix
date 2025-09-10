{ config, ... }:
{
  networks = {
    internet = {
      name = "Internet";
      cidrv4 = "0.0.0.0/0";
    };
    dev = {
      name = "Development Network";
      cidrv4 = "192.168.1.0/24";
    };
    cicd = {
      name = "CI/CD Network";
      cidrv4 = "10.0.0.0/24";
    };
    mgmt = {
      name = "Management Network";
      cidrv4 = "10.1.0.0/24";
    };
  };

  nodes = {
    workstation = {
      deviceType = "device";
      hardware.info = "Development Workstation";
      interfaces = {
        eth0 = {
          network = "dev";
          addresses = [ "192.168.1.100/24" ];
        };
      };
    };

    cicd-server = {
      deviceType = "device";
      hardware.info = "CI/CD Server (Jenkins + Docker)";
      interfaces = {
        eth0 = {
          network = "cicd";
          addresses = [ "10.0.0.10/24" ];
        };
      };
    };

    monitoring-server = {
      deviceType = "device";
      hardware.info = "Monitoring Server (Prometheus + Grafana)";
      interfaces = {
        eth0 = {
          network = "mgmt";
          addresses = [ "10.1.0.10/24" ];
        };
      };
    };

    gateway = {
      deviceType = "device";
      hardware.info = "Gateway/Router";
      interfaces = {
        wan = {
          network = "internet";
          addresses = [ ];
        };
        lan = {
          network = "dev";
          addresses = [ "192.168.1.1/24" ];
        };
        cicd-link = {
          network = "cicd";
          addresses = [ "10.0.0.1/24" ];
        };
        mgmt-link = {
          network = "mgmt";
          addresses = [ "10.1.0.1/24" ];
        };
      };
    };
  };
}
