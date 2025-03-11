{
  system,
  stateVersion,
  ...
}: {
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
