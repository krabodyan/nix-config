{...}: {
  imports = [
    ./network.nix
    ./services.nix
    ./sound.nix
    ./security.nix
    ./system.nix
    ./tlp.nix
    ./env.nix
    ./users.nix
    ./time-locale.nix
    ./nix.nix
    #./bluetooth.nix
  ];
}
