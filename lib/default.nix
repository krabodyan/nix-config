{
  self,
  inputs,
}: let
  inherit (import ./util.nix) mkAssociations allDirs;
  inherit (import ./theme.nix) colors fonts;
  yes = {enable = true;};
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAS98GiFhPvcsST61a6HvWOQr09zoHLTNuydGYt0Rhp";
  mkHost = hostDir: {
    stateVersion,
    system,
    hostname,
    username,
    hidpi ? false,
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
          yes
          publicKey
          hidpi
          ;
      };
      modules = with inputs;
        [
          agenix.nixosModules.default
          disko.nixosModules.default
          asus-numberpad-driver.nixosModules.default
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
    hostname,
    overlays ? [],
    hidpi ? false,
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
          hostname
          stateVersion
          system
          hostDir
          colors
          fonts
          overlays
          yes
          publicKey
          hidpi
          ;
      };
      modules =
        [
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
  genHome = builtins.mapAttrs mkHome;
}
