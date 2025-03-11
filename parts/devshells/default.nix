{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    rust-pkgs = import inputs.nixpkgs {
      inherit (pkgs) system;
      overlays = [(import inputs.rust-overlay)];
    };
    shellHook = ''test -n "$TMUX" || exec tmux'';
  in {
    devShells.rust = pkgs.mkShell {
      inherit shellHook;
      name = "rust";
      meta.description = "DevShell for Rust with Tauri | Dioxus";
      DEV_SHELL_NAME = "rust";
      RUST_BACKTRACE = 1;
      GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";

      nativeBuildInputs = with pkgs; [
        sqlx-cli
        cargo-watch
        cargo-expand
        cargo-tauri
        dioxus-cli
        wasm-bindgen-cli
        gobject-introspection
        nodejs
        tailwindcss
      ];

      buildInputs = with pkgs; [
        openssl
        pkg-config
        (
          rust-pkgs.rust-bin.nightly.latest.default.override
          {
            targets = ["wasm32-unknown-unknown" "x86_64-unknown-linux-gnu"];
            extensions = ["rust-src" "rust-analyzer" "miri"];
          }
        )
      ];
    };
    devShells.ino = pkgs.mkShell {
      DEV_SHELL_NAME = "ino";
      inherit shellHook;
      buildInputs = [pkgs.glibc_multi];
    };
  };
}
