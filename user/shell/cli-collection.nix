{ pkgs, ... }:

{
  # Collection of useful CLI apps
  home.packages = with pkgs; [
    # neofetch like things
    disfetch 
    neofetch
    onefetch

    #cowsay like things
    cowsay 
    fortune
    sl

    #htop like things
    htop
    btop
    bottom #call with btm in terminal

    #vim like things
    vim 
    neovim

    #misc
    cava #visualize audio input in terminal
    libnotify
    timer
    fd #alternative to find 
    tmux
    hwinfo
    unzip
    brightnessctl
    w3m #lynx like terminal browser
    fzf #command line fuzzy finder
    nix-tree
    zip
    nnn
    bc
    direnv
    nix-direnv

  ];

}
