{
  description = "krabodyan system configuration";

  inputs = {
    nixpkgs = {
      type  = "github";
      owner = "nixos";
      repo  = "nixpkgs";
      ref   = "nixos-unstable";
    };
    home-manager = {
      type  = "github";
      owner = "nix-community";
      repo  = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      type  = "github";
      owner = "nix-community";
      repo  = "nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system inputs; };
        modules = [
          ./nixos/configuration.nix
          inputs.disko.nixosModules.default
          (import ./disko.nix { device = "/dev/sda"; })
          inputs.nixvim.nixosModules.nixvim
        ];
      };
      homeConfigurations.krabodyan = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit system inputs; };
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
}
