{
  security.sudo.enable = false;
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
    ];
  };
}
