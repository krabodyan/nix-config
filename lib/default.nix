{
  self,
  inputs,
}: let
  inherit (import ./util.nix) mkAssociations allDirs;
  inherit (import ./theme.nix) colors fonts;
  mkHost = hostDir: {
    stateVersion,
    system,
    hostname,
    username,
    overlays ? [],
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
          fonts
          overlays
          ;
      };
      modules = with inputs;
        [
          disko.nixosModules.default
          sops-nix.nixosModules.sops
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
    overlays ? [],
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
          fonts
          overlays
          ;
      };
      modules =
        [
          inputs.sops-nix.homeManagerModules.sops
          inputs.nix-index-database.hmModules.nix-index
        ]
        ++ [
          "${self}/overlays"
          "${self}/modules/home"
          "${self}/hosts/${hostDir}/home"
          "${self}/hosts/${hostDir}/home/modules"
        ];
    };
in {
  genNixos = builtins.mapAttrs mkHost;
  genHome = hosts:
    builtins.listToAttrs (
      builtins.map (name: {
        name = hosts.${name}.username;
        value = mkHome name hosts.${name};
      }) (builtins.attrNames hosts)
    );
}
