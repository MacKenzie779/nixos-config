{ config, lib, pkgs, ... }:

{
  imports = [ ./pipewire.nix
              ./dbus.nix
              ./gnome-keyring.nix
              ./fonts.nix
            ];

  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
    };
    displayManager.sddm.wayland.enable = true;
    displayManager.sddm.sugarCandyNix = {
      enable = true;
    };
  };
}
