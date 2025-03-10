{
  self,
  inputs,
}: let
  inherit (import ./util.nix) mkAssociations allDirs;
  inherit (import ./theme.nix) colors systemFont;
  mkHost = hostDir: {
    stateVersion,
    platform,
    hostname,
    username,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          self
          allDirs
          mkAssociations
          hostname
          username
          stateVersion
          platform
          hostDir
          colors
          systemFont
          ;
      };
      modules = with inputs;
        [
          disko.nixosModules.default
        ]
        ++ ["${self}/modules/system"];
    };
  mkHome = homeDir: {
    stateVersion,
    platform,
    username,
    ...
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = platform;
        config = {
          allowUnfree = true;
          allowBroken = true;
          allowInsecurePredicate = _: true;
        };
      };
      extraSpecialArgs = {
        inherit
          inputs
          self
          allDirs
          mkAssociations
          username
          stateVersion
          platform
          homeDir
          colors
          systemFont
          ;
      };
      modules = ["${self}/modules/home"];
    };
in {
  forAllSystems = inputs.nixpkgs.lib.systems.flakeExposed;

  genNixos = builtins.mapAttrs mkHost;
  genHome = builtins.mapAttrs mkHome;
}
