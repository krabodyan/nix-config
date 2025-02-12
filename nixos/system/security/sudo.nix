{ pkgs, ... }: {
  security.sudo.enable = false;
  environment.systemPackages = [ pkgs.doas-sudo-shim ];
  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        noPass = false;
        keepEnv = true;
        persist = true;
      }
      {
        users = [ "krabodyan" ];
        cmd = "intel_gpu_top";
        noPass = true;
      }
      {
        users = [ "krabodyan" ];
        cmd = "iotop";
        noPass = true;
      }
      {
        users = [ "krabodyan" ];
        cmd = "iftop";
        noPass = true;
      }
    ];
  };
}
