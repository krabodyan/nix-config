{
  self,
  inputs,
}: let
  inherit (import ./util.nix) mkAssociations allDirs;
  inherit (import ./theme.nix) colors fonts;
  yes = {enable = true;};
  keys = {
    id_ed25519 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAS98GiFhPvcsST61a6HvWOQr09zoHLTNuydGYt0Rhp";
    id_rsa = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3s+fIJqMvtmrLXmXVm8SH4ZUauqeWvJyeCU3irnrNaGqwxfZ4Vj8Pcmni7nEsP6JCXNEcPzdPg5+DP0ZFfj9lhTU+HmZWBx/x2Ew86wPtayQ2/Wy3YAGsomT8GAutopRAsxh+PWkl+/6ZzC5k6XAJD6PIBI2mX9oAE/1oWPY/gswmt+kvDy4PBtrgNuC0ee1W72u2moCeZOVjxYOUZwv+2P5s76hAqudETd5hp+36oFd/6AXR2Q4zDl3DU/Ht/KKCtyAYOSLw6OMCmKJEi+zsr3ew/sJjDhxuViIlV5Lz/fBTQ3s/ussMx+q5eL4hbFSJF6wba3/lm0GAGUV9XdtlJBuC6/BnmoGEDNylsYVIKQark3ZIJrMTCy45rilmLbuoepfdsZkAy6htHXQqN87da+q2yWOs8JnrKc1aPnTdgBWZZLXbjacsf7xAtyP+5BWy6hz00BqKLgwB6wMS0rWdx6Ix1kbFiAAK7wL+ehllZeOH4pLoPEFbJesOm2n0SvE=";
  };
  overlays = [(import ../overlays {inherit inputs;}).overlay];
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
          keys
          hidpi
          ;
      };
      modules = with inputs;
        [
          agenix.nixosModules.default
          disko.nixosModules.default
          {
            nixpkgs.overlays = overlays;
          }
        ]
        ++ [
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
    hidpi ? false,
    ...
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system overlays;
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
          yes
          keys
          hidpi
          ;
      };
      modules =
        [
          inputs.nix-index-database.homeModules.nix-index
        ]
        ++ [
          "${self}/modules/home"
          "${self}/hosts/${hostDir}/home"
          "${self}/hosts/${hostDir}/home/modules"
        ];
    };
in {
  genNixos = builtins.mapAttrs mkHost;
  genHome = builtins.mapAttrs mkHome;
}
