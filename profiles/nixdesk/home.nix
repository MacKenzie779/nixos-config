{ config, pkgs, stylix, userSettings, ... }:

{

  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  imports = [
	  stylix.homeManagerModules.stylix	
    (./. + "../../../user/wm"+("/"+userSettings.wm+"/"+userSettings.wm)+".nix")
    ../../user/shell/sh.nix # My zsh and bash config
    ../../user/shell/cli-collection.nix # Useful CLI apps
    ../../user/app/ranger/ranger.nix # My ranger file manager config
    ../../user/app/git/git.nix # My git config
    (./. + "../../../user/app/browser"+("/"+userSettings.browser)+".nix") # My default browser selected from flake
    ../../user/app/virtualization/virtualization.nix # Virtual machines
    ../../user/style/stylix.nix # Styling and themes for my apps
    ../../user/hardware/bluetooth.nix # Bluetooth
  ];

  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Core
    zsh
    alacritty
    brave
    dmenu
    rofi
    git
    vscode
    discord

    # Office
    libreoffice-fresh
    xournalpp
    newsflash
    gnome.nautilus
    gnome.gnome-calendar
    openvpn
    #protonmail-bridge
    texliveSmall

    # Media
    gimp-with-plugins
    pinta
    krita
    musikcube
    vlc
    yt-dlp
    blender
    obs-studio
    kdenlive
    ffmpeg
  ];

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
      XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
      XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
      XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
      XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
      XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };

}

