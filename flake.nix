{
  description = "My system configuration";

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

    #hyprlock.url = "github:hyprwm/Hyprlock";

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?rev=cba1ade848feac44b2eda677503900639581c3f4";

    #waybar = {
    #  url = "git+https://github.com/Alexays/Waybar?rev=0251e25f234d24300b9f1063896e13a188fda03c";
    #};
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
