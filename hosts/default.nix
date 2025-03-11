{
  self,
  hostDir,
  system,
  stateVersion,
  ...
}: {
  imports = [
    "${self}/modules/system"
    "${self}/hosts/${hostDir}"
    "${self}/hosts/${hostDir}/modules"
  ];

  system = {
    inherit stateVersion;
  };

  nixpkgs.hostPlatform = system;
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    allowInsecurePredicate = _: true;
  };
}
