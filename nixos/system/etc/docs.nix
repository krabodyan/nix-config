{lib, ...}: {
  documentation = {
    enable = lib.mkDefault false;
    dev.enable = lib.mkDefault false;
    doc.enable = lib.mkDefault false;
    info.enable = lib.mkDefault false;
    man.enable = lib.mkDefault false;
    nixos.enable = lib.mkDefault false;
  };
}
