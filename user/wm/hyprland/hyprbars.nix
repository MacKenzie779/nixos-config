{ config, lib, stdenv, pkgs, hyprland-plugins, ... }:

stdenv.mkDerivation rec {
        pname = "hyprbars";
        version = "unstable";
        src = "${hyprland-plugins}/hyprbars";
        nativeBuildInputs = [ pkgs.hyprland.nativeBuildInputs ];
        buildInputs = [ pkgs.hyprland pkgs.hyprland.buildInputs ];
}
