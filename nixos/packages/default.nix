{ inputs, ... }: {
  imports = [ ./system.nix ./steam.nix ./fonts.nix ];

  environment.etc.nixpkgs.source = inputs.nixpkgs;
}
