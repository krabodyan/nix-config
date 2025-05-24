let
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAS98GiFhPvcsST61a6HvWOQr09zoHLTNuydGYt0Rhp";
in {
  "password.age".publicKeys = [key];
  "ssh.age".publicKeys = [key];
}
