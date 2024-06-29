{inputs, ...}: {
  imports = [
    ./system.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.etc.nixpkgs.source = inputs.nixpkgs;
}
