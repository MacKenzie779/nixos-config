{ config, pkgs, ...} : 
{
	services.xserver.enable = true;
	services.xserver.xkb.layout = "de";
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;
}
