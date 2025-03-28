{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    rust-pkgs = import inputs.nixpkgs {
      inherit (pkgs) system;
      overlays = [(import inputs.rust-overlay)];
    };
  in {
    devShells.rust = pkgs.mkShell {
      name = "rust";
      meta.description = "Light DevShell for Rust";
      LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
      DEV_SHELL_NAME = "rust";
      RUST_BACKTRACE = 1;

      nativeBuildInputs = with pkgs; [
        cargo-watch
        cargo-expand
        pkg-config
        openssl
      ];

      buildInputs = with pkgs; [
        sqlite.dev
        llvmPackages.clang
        libudev-zero
        (
          rust-pkgs.rust-bin.nightly.latest.default.override
          {
            targets = ["x86_64-unknown-linux-gnu"];
            extensions = ["rust-src" "rust-analyzer"];
          }
        )
      ];
    };
    devShells.tauri = pkgs.mkShell {
      name = "tauri";
      meta.description = "DevShell for Rust with Tauri";
      DEV_SHELL_NAME = "tauri";
      RUST_BACKTRACE = 1;
      GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";

      nativeBuildInputs = with pkgs; [
        cargo-watch
        cargo-expand
        cargo-tauri
        pnpm
        tailwindcss
        gobject-introspection
        nodejs
        pkg-config
        openssl
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
            targets = ["wasm32-unknown-unknown" "x86_64-unknown-linux-gnu"];
            extensions = ["rust-src" "rust-analyzer"];
          }
        )
      ];
    };
    devShells.ino = pkgs.mkShell {
      DEV_SHELL_NAME = "ino";
      buildInputs = with pkgs; [
        glibc_multi
        pkgsCross.avr.buildPackages.gcc
        platformio
      ];
    };
  };
}
