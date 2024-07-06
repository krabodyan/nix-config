{
  imports = [ ./sudo.nix ];
  security.pam.loginLimits = [
    {
      domain = "krabodyan";
      type = "soft";
      item = "core";
      value = "unlimited";
    }
  ];

  security.pam.services.swaylock = { };
}
