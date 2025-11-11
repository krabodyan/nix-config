{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    rust-pkgs = import inputs.nixpkgs {
      inherit (pkgs.stdenv.hostPlatform) system;
      overlays = [(import inputs.rust-overlay)];
    };
  in {
    devShells.rust = pkgs.mkShell {
      name = "rust";
      DEV_SHELL_NAME = "rust";
      runScript = "fish";
      RUST_BACKTRACE = 1;
      RUST_LOG = "DEBUG";

      LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";

      nativeBuildInputs = with pkgs; [
        pkg-config
        clang
      ];

      buildInputs = with pkgs; [
        opencv4.cxxdev
        (
          rust-pkgs.rust-bin.stable.latest.default.override
          {
            targets = ["x86_64-unknown-linux-gnu"];
            extensions = [
              "rust-src"
              # "llvm-tools-preview"
              "rust-analyzer"
              # "miri"
            ];
          }
        )
      ];
    };

    devShells.cuda = pkgs.mkShell {
      name = "cuda";
      DEV_SHELL_NAME = "cuda";
      runScript = "fish";

      buildInputs = with pkgs; [
        cmake

        fmt.dev
        curl.dev
        boost.dev
        opencv.cxxdev
        openssl.dev
        nlohmann_json
        onnxruntime.dev

        cudaPackages.cudatoolkit
        cudaPackages.tensorrt

        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly
        gst_all_1.gst-libav
        gst_all_1.gst-vaapi
      ];

      CUDA_TOOLKIT_ROOT_DIR = "${pkgs.cudaPackages.cudatoolkit.out}";
    };

    devShells.rasp = pkgs.mkShell {
      name = "rasp";
      DEV_SHELL_NAME = "rasp";
      runScript = "fish";

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
      runScript = "fish";

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
      runScript = "fish";

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
      runScript = "fish";

      CUDA_TOOLKIT_ROOT_DIR = "${pkgs.cudaPackages.cudatoolkit.out}";

      buildInputs = with pkgs.python313Packages; [
        torch
        grad-cam
        ultralytics
        opencv-python

        tensorrt

        matplotlib
        numpy
        pandas
        scipy

        plotly

        psycopg2-binary
        pyyaml
      ];
    };
  };
}
