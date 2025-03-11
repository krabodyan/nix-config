{
  self,
  inputs,
}: let
  inherit (import ./util.nix) mkAssociations allDirs;
  inherit (import ./theme.nix) colors systemFont;
  mkHost = hostDir: {
    stateVersion,
    system,
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
          system
          hostDir
          colors
          systemFont
          ;
      };
      modules = with inputs;
        [
          disko.nixosModules.default
        ]
        ++ [
          "${self}/overlays"
          "${self}/modules/system"
          "${self}/hosts/${hostDir}/system"
          "${self}/hosts/${hostDir}/system/modules"
        ];
    };
  mkHome = hostDir: {
    stateVersion,
    system,
    username,
    ...
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system;
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
          system
          hostDir
          colors
          systemFont
          ;
      };
      modules = [
        "${self}/overlays"
        "${self}/modules/home"
        "${self}/hosts/${hostDir}/home"
        "${self}/hosts/${hostDir}/home/modules"
      ];
    };
in {
  forAllSystems = inputs.nixpkgs.lib.systems.flakeExposed;

  genNixos = builtins.mapAttrs mkHost;
  genHome = builtins.mapAttrs mkHome;
}
