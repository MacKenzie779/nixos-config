# My NixOS installation guide

## Booting into live iso

### Setting keyboard layout

On minimal iso: 

```bash
loadkeys de-latin1
```

On X-Server iso:

```bash
setxkbmap de
```

## Partitioning

Creating new gpt partition table

```bash
parted /dev/sda -- mklabel gpt
```

Setting up partition layout with cfdisk

```bash
cfdisk /dev/sda
```

Partition layout:

| Device    | Size                   | Type             |
| --------- | ---------------------- | ---------------- |
| /dev/sda1 | 512M                   | EFI System       |
| /dev/sda2 | 8G (size of your RAM)  | Linux Swap       |
| /dev/sda3 | 457G (free space left) | Linux Filesystem |

Format the partitions

```bash
mkfs.fat -F 32 -n boot /dev/sda1
mkswap -L swap /dev/sda2
mkfs.ext4 -L nixos /dev/sda3
```

## Mounting

```bash
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/sda2
```

## Initial NixOS Configuration

```bash
nixos-generate-config --root /mnt
```

Generates /etc/nixos/configuration.nix and /etc/nixos/hardware-configuration.nix in /mnt

## System installation

```bash
nixos-install
```

## Install some package

For example: git

```bash
sudo nix-env -iA nixos.git
```

Showing all packages installed via nix-env

```bash
sudo nix-env -q
```

Uninstall a package

```bash
sudo nix-env --uninstall git
```

## Update&Upgrade

```bash
nix-channel --update
nixos-rebuild switch --upgrade
```

## Garbage collection

List all generations

```bash
nix-env --list-generations
nix-env --delete-generations 1
nix-env --delete-older-than 7d
```

```bash
nix-collect-garbage
sudo nix-collect-garbage -d 
```

---

## Home Manager

### Installation

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
sudo nix-channel --update
```

#### As a NixOs Module

In /etc/nixos/configuration.nix

```nix
imports = [<home-manager/nixos>];
home-manager.users.user = { pkgs, ... }: {
    home.packages = [ pkgs.sl ];
    home.stateVersion = "23.11";
};
```

#### Standalone

```bash
nix-shell '<home-manager>' -A install
```

Apply changes on homemanager (standalone)

```bash
home-manager switch
```

Remove a channel

```bash
sudo nix-channel --remove home-manager
```

## Flakes

### Installation:

Add following to /etc/nixos/configuration.nix

```bash
nix = {
  package = pkgs.nixFlakes;
  extraOptions = "experimental-features = nix-command flakes";
};
```

### Generate flake.nix

```bash
cd ~
mkdir flake
cd flake
nix flake init
```

### Build it

```bash
sudo nixos-rebuild switch --flake .#
```