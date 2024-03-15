# NixOS noob trying to build his system

My NixOS configuration using home-manager and flakes

Inspired by https://github.com/librephoenix/nixos-config/

# Installing instructions

## First steps

1. Download the minimal NixOS ISO image from https://nixos.org/download.html/nixos-iso

2. Boot into the NixOS installer

3. Run `sudo -i` to obtain root privileges

4. If necessary, change the keyboard layout (e.g. `loadkeys de`)

5. Now connect your machine with the internet

## Paritioning

We are implementing following example parition layout:

| Device    | Size                   | Filesystem | Label |
| --------- | ---------------------- | ---------- | ----- |
| /dev/sda1 | 457G (free space left) | ext4       | nixos |
| /dev/sda2 | 8G (size of your RAM)  | swap       | swap  |
| /dev/sda3 | 512M                   | fat32      | boot  |

Create new gpt partition table

```bash
parted /dev/sda -- mklabel gpt
```

Create new root partition

```bash
parted /dev/sda -- mkpart root ext4 512MB -8GB
```

Create new swap partition

```bash
parted /dev/sda -- mkpart swap linux-swap -8GB 100%
```

Create new boot partition

```bash
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
```

```bash
parted /dev/sda -- set 3 esp on
```

## Formating the new partitions

```bash
mkfs.ext4 -L nixos /dev/sda1
```

```bash
mkswap -L swap /dev/sda2
```

```bash
mkfs.fat -F 32 -n boot /dev/sda3
```

## Mounting the new partitions

```bash
mount /dev/disk/by-label/nixos /mnt
```

```bash
mkdir -p /mnt/boot
```

```bash
mount /dev/disk/by-label/boot /mnt/boot
```

```bash
swapon /dev/disk/by-label/swap
```

## Installing the NixOS configuration

Enable flakes on the live system and install git

```bash
mkdir -p ~/.config/nix/
echo experimental-features = nix-command flakes > ~/.config/nix/nix.conf
nix profile install nixpkgs#git
```

```bash
mkdir -p /mnt/home/user/
cd /mnt/home/user
```

Clone repository

```bash
git clone "https://github.com/MacKenzie779/nixos-config.git"
cd nixos-config
nano flake.nix
```

Generate hardware config for new system

```bash
nixos-generate-config --root /mnt --show-hardware-config > profiles/nixdesk/hardware-configuration.nix
git add .
```

Install base system

```bash
nixos-install --flake .#system
reboot
```

Login as root and set user password

```bash
passwd user
```
Exit as root and login as user in order to install the home-manager configuration

```bash
nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-fetaures flakes -- switch --flake ./nixos-config#user
reboot
```
