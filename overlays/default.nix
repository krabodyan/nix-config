{inputs, ...}: {
  overlay = final: prev: {
    pinned = import inputs.nixpkgs-pinned {
      inherit (prev.stdenv.hostPlatform) system;
      config = {
        allowUnfree = true;
        allowBroken = true;
        allowUnfreePredicate = _: true;
        allowInsecurePredicate = _: true;
      };
    };

    # FIXME remove
    nwjs = prev.nwjs.overrideAttrs {
      version = "0.84.0";
      src = prev.fetchurl {
        url = "https://dl.nwjs.io/v0.84.0/nwjs-v0.84.0-linux-x64.tar.gz";
        hash = "sha256-VIygMzCPTKzLr47bG1DYy/zj0OxsjGcms0G1BkI/TEI=";
      };
    };
  };
}
