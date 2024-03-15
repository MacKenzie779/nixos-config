# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, systemSettings, userSettings, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../system/boot/systemdboot.nix
    ../../system/hardware/kernel.nix # Kernel config
    ../../system/hardware/time.nix # Network time sync
    ../../system/hardware/opengl.nix
    #../../system/hardware/bluetooth.nix
    (./. + "../../../system/wm"+("/"+userSettings.wm)+".nix") # My window manager
    ../../system/app/prismlauncher.nix
    ../../system/app/automount.nix # important for automounting devs like usb
    ../../system/app/virtualization.nix
    #( import ../../system/app/docker.nix {storageDriver = "btrfs"; inherit userSettings lib;} )
    ../../system/style/stylix.nix
  ];

  # Ensure nix flakes are enabled
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs.config.allowUnfree = true;

  # Networking
  networking.hostName = systemSettings.hostname; # Define your hostname.
  networking.networkmanager.enable = true; # Use networkmanager

  security.polkit.enable = true;

  # Timezone and locale
  time.timeZone = systemSettings.timezone; # time zone
  i18n.defaultLocale = systemSettings.locale_us;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale_de;
    LC_IDENTIFICATION = systemSettings.locale_de;
    LC_MEASUREMENT = systemSettings.locale_de;
    LC_MONETARY = systemSettings.locale_de;
    LC_NAME = systemSettings.locale_de;
    LC_NUMERIC = systemSettings.locale_de;
    LC_PAPER = systemSettings.locale_de;
    LC_TELEPHONE = systemSettings.locale_de;
    LC_TIME = systemSettings.locale_de;
  };

  console.keyMap = "de";

  # User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = [];
    uid = 1000;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    zsh
    git
    home-manager
  ];

  # I use zsh btw
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  fonts.fontDir.enable = true;

  # It is ok to leave this unchanged for compatibility purposes
  system.stateVersion = "22.11";

}
