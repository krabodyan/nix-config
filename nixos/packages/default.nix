{inputs, ...}: {
  imports = [
    ./system.nix
    ./nixvim
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.etc.nixpkgs.source = inputs.nixpkgs;
}
