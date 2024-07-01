{inputs, ...}: {
  imports = [
    ./system.nix
    ./steam.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.etc.nixpkgs.source = inputs.nixpkgs;
}
