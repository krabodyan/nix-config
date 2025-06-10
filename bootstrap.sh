#!/usr/bin/env bash

host=""
disk=""
key="agekey"

read -r -p "Enter host (asus/hp/zenbook): " host

if ! test -f "$key"; then
	echo "identity file not found. should be named '$key'"
	exit 1
fi

read -r -p "Enter disk: " disk

if [[ "${disk}" ]]; then
	sudo nix \
		--extra-experimental-features "nix-command flakes" \
		run github:nix-community/disko -- \
		--mode zap_create_mount "hosts/$host/system/modules/disks/default.nix" \
		--arg device "$disk" || exit 1
fi

sudo mkdir -p /mnt/etc/ssh || exit 1
sudo cp -v "$key" "/mnt/etc/ssh/" || exit 1

if [[ "${host}" ]]; then
	sudo nixos-install --flake ".#$host" --root /mnt --no-root-password
fi
