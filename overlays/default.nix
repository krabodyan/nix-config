{
  pkgs,
  inputs,
  overlays,
  ...
}: {
  nixpkgs.overlays =
    (map
      (overlay: inputs.${overlay}.overlay)
      overlays)
    ++ [
      (final: prev: {
        betaflight-configurator = prev.betaflight-configurator.override {
          nwjs = inputs.nixpkgs-nwjs.legacyPackages.${pkgs.system}.nwjs084;
        };
      })
    ];
}
