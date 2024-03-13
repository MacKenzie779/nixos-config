{ config, pkgs, ... }:

{
  imports = [ ./pipewire.nix
              ./dbus.nix
              ./gnome-keyring.nix
              ./fonts.nix
            ];

  #environment.systemPackages = with pkgs;
 #   [ wayland waydroid
 #     (sddm-chili-theme.override {
 #       themeConfig = {
 #         background = config.stylix.image;
 #         ScreenWidth = 1920;
 #         ScreenHeight = 1080;
  #        blur = true;
  #        recursiveBlurLoops = 3;
  #        recursiveBlurRadius = 5;
 #       };})
 #   ];

  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
    displayManager.sddm.sugarCandyNix = {
      enable = true;
      wayland.enable = true;
      settings = {
        # Set your configuration options here.
        # Here is a simple example:
        Background = lib.cleanSource ./background.png;
        ScreenWidth = 1920;
        ScreenHeight = 1080;
        FormPosition = "left";
        HaveFormBackground = true;
        PartialBlur = true;
        # ...
      };

    };
  };
}
