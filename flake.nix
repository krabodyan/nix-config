{
  description = "my flake";

  nixConfig = {
    extra-substituters = [
      "https://helix.cachix.org"
      "https://cache.garnix.io"
      "https://nixpkgs-wayland.cachix.org"
      # "https://yazi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      # "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix.url = "github:helix-editor/helix";
    ayugram.url = "github:kaeeraa/ayugram-desktop/release";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    # yazi.url = "github:sxyazi/yazi";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ inputs.nixpkgs-wayland.overlay ];
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self system inputs; };
        modules = [
          ./lib/theme.nix
          ./nixos/configuration.nix
          inputs.disko.nixosModules.default
          (import ./disko.nix { device = "/dev/nvme0n1"; })
        ];
      };

      homeConfigurations.krabodyan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit self system inputs;
          helpers = import ./lib/helpers.nix;
        };
        modules = [ ./home-manager ];
      };

      devShells.${system} = {
        # rust = let
        # overlays = [ (import inputs.rust-overlay) ];
        # pkgs = import nixpkgs { inherit system overlays; };
        # rust = pkgs.rust-bin.nightly.latest.default.override {
        #   extensions = [ "rust-src" "rust-analyzer" ];
        # };
        rust = pkgs.mkShell {
          buildInputs = [ pkgs.llvmPackages.clang ];
          nativeBuildInputs = with pkgs; [
            pkg-config
            openssl.dev
            luajit
            # alsa-lib.dev
            # libpulseaudio.dev
            postgresql.dev
            # fontconfig.dev
          ];
          RUST_BACKTRACE = 1;
          LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
        };
        dwl = pkgs.mkShell {
          packages = [ pkgs.gnumake ];
          nativeBuildInputs = with pkgs; [
            pkg-config
            wayland-scanner.dev
            wayland-protocols
            wlroots
            wayland
            xwayland
            xorg.xcbutilwm
            libxkbcommon
            libinput
            xorg.libxcb
            pixman
            libinput

            xorg.libX11
            xorg.libXinerama
            xorg.libXft
          ];
          makeFlags = [
            "PKG_CONFIG=${pkgs.stdenv.cc.targetPrefix}pkg-config"
            "WAYLAND_SCANNER=wayland-scanner"
            "PREFIX=$(out)"
            "MANDIR=$(man)/share/man"
            ''XWAYLAND="-DXWAYLAND"''
            ''XLIBS="xcb xcb-icccm"''
          ];
        };
        python = pkgs.mkShell {
          packages = [
            (pkgs.python311.withPackages (python-pkgs:
              with python-pkgs; [
                numpy
                nltk
                wordcloud
                prettytable
                xlrd
                tqdm
                networkx
                matplotlib
                scikit-learn
                pandas
                seaborn
                requests
                openpyxl
                certifi
                tabulate
                keras
                termcolor
                (buildPythonPackage rec {
                  pname = "ucimlrepo";
                  version = "0.0.7";
                  src = fetchPypi {
                    inherit pname version;
                    sha256 =
                      "sha256-TP8/noFDZ91glW2pmazkcxlyN7n85MB+mmied7T/tZo=";
                  };
                  doCheck = false;
                  propagatedBuildInputs = [ numpy ];
                })
                (buildPythonPackage rec {
                  pname = "blosum";
                  version = "2.0.3";
                  src = fetchPypi {
                    inherit pname version;
                    sha256 =
                      "sha256-b+5ol1wEIR/Hwpj1jL8eWwIeooeeUUVtk0I46J6irps=";
                  };
                  doCheck = false;
                })
                (buildPythonPackage rec {
                  pname = "idx2numpy";
                  version = "1.2.3";
                  src = fetchPypi {
                    inherit pname version;
                    sha256 =
                      "sha256-VZtXio9ppBr1TPFcjfxDq584Dgp9YCqEvauvUqz7vT4=";
                  };
                  doCheck = false;
                })
              ]))
          ];
        };
      };
    };
}
