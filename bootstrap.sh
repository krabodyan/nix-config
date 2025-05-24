#!/usr/bin/env bash

host=""
disk=""

read -r -p "Enter host (asus/hp): " host

if ! test -f "$host"; then
	echo "identity file not found. should be named '$host'"
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

mkdir -p /mnt/etc/ssh
cp -v "$host" "/mnt/etc/ssh/"

if [[ "${host}" ]]; then
	sudo nixos-install --flake ".#$host" --root /mnt --no-root-password
fi
