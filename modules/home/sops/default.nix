{
  self,
  hostname,
  ...
}: {
  sops = {
    defaultSopsFile = "${self}/secrets/${hostname}/secrets.yaml";
    age.keyFile = "/etc/sops-nix/keys.txt";
  };
}
