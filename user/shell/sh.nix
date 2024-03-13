{ pkgs, ... }:
let

  # My shell aliases
  myAliases = {
    ls = "ls --color=auto -h --group-directories-first";
    audio = "pavucontrol";
    wlan = "nmtui";
    timel = "timedatectl set-ntp 1";
    reloadzsh = "source ~/.zshrc";
    rebhome = "nix run home-manager -- switch --flake ~/nixos-config#user";
    rebos = "sudo nixos-rebuild switch --flake ~/nixos-config#system";
    gitfetch = "onefetch";
  };
  
in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = myAliases;
    initExtra = ''
    PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
     %F{green}→%f "
    [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}
