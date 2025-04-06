#!/usr/bin/env bash

host=""
disk=""
read -r -p "Enter disk: " disk
read -r -p "Enter host (asus/hp): " host

if [[ "${disk}" ]]; then
  sudo nix \
    --extra-experimental-features "nix-command flakes" \
    run github:nix-community/disko -- \
    --mode zap_create_mount "hosts/$host/system/modules/disks/default.nix" \
    --arg device "$disk" || exit 1
fi

if ! test -f "keys.txt"; then
  echo keys.txt not found
  echo add keys.txt to this directory
fi

sudo mkdir /mnt/etc/sops-nix/
sudo cp "keys.txt" /mnt/etc/sops-nix/

if [[ "${host}" ]]; then
  sudo nixos-install --flake ".#$host" --root /mnt --no-root-password
fi
