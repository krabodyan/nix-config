{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    rust-pkgs = import inputs.nixpkgs {
      inherit (pkgs) system;
      overlays = [(import inputs.rust-overlay)];
    };
  in {
    devShells.rust = pkgs.mkShell {
      name = "rust";
      DEV_SHELL_NAME = "rust";
      RUST_BACKTRACE = 1;
      RUST_LOG = "DEBUG";

      nativeBuildInputs = [pkgs.pkg-config];

      buildInputs = [
        (
          rust-pkgs.rust-bin.nightly.latest.default.override
          {
            targets = ["x86_64-unknown-linux-gnu"];
            extensions = [
              "rust-src"
              "llvm-tools-preview"
              "rust-analyzer"
              "miri"
            ];
          }
        )
      ];
    };

    devShells.rasp = pkgs.mkShell {
      name = "rasp";
      DEV_SHELL_NAME = "rasp";

      RUST_BACKTRACE = 1;
      RUST_LOG = "DEBUG";
      CARGO_BUILD_TARGET = "thumbv6m-none-eabi";

      nativeBuildInputs = with pkgs; [
        pkg-config
        elf2uf2-rs
        picotool
        minicom
      ];

      buildInputs = [
        (
          rust-pkgs.rust-bin.nightly.latest.default.override
          {
            targets = ["thumbv6m-none-eabi"];
            extensions = [
              "rust-src"
              "rust-analyzer"
            ];
          }
        )
      ];
    };

    devShells.tauri = pkgs.mkShell {
      name = "tauri";
      DEV_SHELL_NAME = "tauri";

      RUST_BACKTRACE = 1;
      RUST_LOG = "DEBUG";

      GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";

      nativeBuildInputs = with pkgs; [
        pkg-config
        tailwindcss
        gobject-introspection
        nodejs
      ];

      buildInputs = with pkgs; [
        sqlite.dev
        libudev-zero
        at-spi2-atk
        atkmm
        cairo
        gdk-pixbuf
        glib
        gtk3
        harfbuzz
        librsvg
        libsoup_3
        pango
        xdotool
        webkitgtk_4_1
        (
          rust-pkgs.rust-bin.nightly.latest.default.override
          {
            targets = ["x86_64-unknown-linux-gnu"];
            extensions = [
              "rust-src"
              "rust-analyzer"
            ];
          }
        )
      ];
    };

    devShells.ino = pkgs.mkShell {
      name = "ino";
      DEV_SHELL_NAME = "ino";

      buildInputs = with pkgs; [
        glibc_multi
        pkgsCross.avr.buildPackages.gcc
        platformio
        minicom
      ];
    };

    devShells.pp = pkgs.mkShell {
      name = "py";
      DEV_SHELL_NAME = "py";

      buildInputs = with pkgs.python313Packages; [
        matplotlib
        numpy
        pandas
        plotly
        psycopg2-binary
        pyyaml
        pygame
      ];
    };
  };
}
