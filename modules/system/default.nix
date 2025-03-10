{
  self,
  allDirs,
  stateVersion,
  ...
}: {
  imports = allDirs "${self}/modules/system";
  system = {
    inherit stateVersion;
  };
}
