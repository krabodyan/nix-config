{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    rust-pkgs = import inputs.nixpkgs {
      inherit (pkgs) system;
      overlays = [(import inputs.rust-overlay)];
    };
    rust-default-utils = with pkgs; [
      cargo-show-asm
      cargo-llvm-cov
      cargo-expand
      cargo-watch
      pkg-config
    ];
  in {
    devShells.rust = pkgs.mkShell {
      name = "rust";
      LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
      DEV_SHELL_NAME = "rust";
      RUST_BACKTRACE = 1;
      RUST_LOG = "DEBUG";

      nativeBuildInputs = with pkgs;
        rust-default-utils
        ++ [
          openssl
        ];

      buildInputs = with pkgs; [
        sqlite.dev
        libudev-zero
        fontconfig
        dbus.dev
        llvmPackages.clang
        (
          rust-pkgs.rust-bin.nightly.latest.default.override
          {
            targets = ["x86_64-unknown-linux-gnu"];
            extensions = ["rust-src" "rust-analyzer" "llvm-tools-preview"];
          }
        )
      ];
    };

    devShells.rasp = pkgs.mkShell {
      name = "rasp";
      DEV_SHELL_NAME = "rasp";
      RUST_BACKTRACE = 1;
      CARGO_BUILD_TARGET = "thumbv6m-none-eabi";
      RUST_LOG = "DEBUG";

      nativeBuildInputs = with pkgs;
        rust-default-utils
        ++ [
          elf2uf2-rs
          picotool
          minicom
        ];
      buildInputs = [
        (
          rust-pkgs.rust-bin.nightly.latest.default.override
          {
            targets = ["thumbv6m-none-eabi"];
            extensions = ["rust-src" "rust-analyzer"];
          }
        )
      ];
    };

    devShells.tauri = pkgs.mkShell {
      name = "tauri";
      LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
      DEV_SHELL_NAME = "tauri";
      RUST_BACKTRACE = 1;
      GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";
      RUST_LOG = "DEBUG";

      nativeBuildInputs = with pkgs;
        rust-default-utils
        ++ [
          tailwindcss
          gobject-introspection
          nodejs
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
            targets = ["x86_64-unknown-linux-gnu"];
            extensions = ["rust-src" "rust-analyzer"];
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
  };
}
