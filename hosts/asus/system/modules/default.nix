{
  self,
  allDirs,
  hostDir,
  ...
}: {
  imports = allDirs "${self}/hosts/${hostDir}/modules/";
}
