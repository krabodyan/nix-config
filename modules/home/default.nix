{
  self,
  allDirs,
  ...
}: {
  imports = allDirs "${self}/modules/home/cli" ++ allDirs "${self}/modules/home/gui";
}
