{
  lib,
  device ? throw "Set this to your disk device, e.g. /dev/sda",
  ...
}:

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";

        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            ZFS = {
              name = "zfs";
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
    };

    zpool = {
      rpool = {
        type = "zpool";
        mode = "single";

        options = {
          ashift = "12";
          autotrim = "on";
        };

        rootFsOptions = {
          compression = "zstd";
          atime = "off";
          xattr = "sa";
          acltype = "posixacl";
          normalization = "formD";
        };

        datasets = {
          "root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options = {
              mountpoint = "legacy";
            };
          };

          "home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            options = {
              mountpoint = "legacy";
            };
          };

          "nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options = {
              mountpoint = "legacy";
            };
          };
        };
      };
    };
  };
}
