{
  device ? throw "set your disk",
  ...
}:
{
  disko.devices = {
    disk.main = {
      type = "disk";
      name = "disk";
      inherit device;
      content = {
        type = "gpt";
        partitions = {
          esp = {
            name = "NIXEFI";
            end = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              extraArgs = [ "-F32" ];
              mountpoint = "/boot";
            };
          };
          root = {
            name = "NIXROOT";
            end = "-0";
            content =
              let
                options = [
                  "noatime"
                  "ssd"
                  "autodefrag"
                  "space_cache=v2"
                  "commit=120"
                  "compress-force=zstd:1"
                ];
              in
              {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/nix" = {
                    mountOptions = options ++ [ "subvol=nix" ];
                    mountpoint = "/nix";
                  };
                  "/home" = {
                    mountOptions = options ++ [ "subvol=home" ];
                    mountpoint = "/home";
                  };
                  "/root" = {
                    mountOptions = options ++ [ "subvol=root" ];
                    mountpoint = "/";
                  };
                };
              };
          };
        };
      };
    };
  };
}
