{ config, pkgs, nixpkgs, ... }: { 
  	imports = [
  		./sound.nix
		./pkgs.nix
  	];
	 
  	networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  	time.timeZone = "Europe/Berlin";

  	i18n.defaultLocale = "en_US.UTF-8";
  
  	console = {
    		font = "Lat2-Terminus16";
    		keyMap = "de";
  	};
}
