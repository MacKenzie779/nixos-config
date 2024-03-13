{ pkgs, ... }: {
	imports = [
		./libreoffice.nix
		./git.nix
		./alacritty.nix	
	];
	home.packages = with pkgs; [
		sl
		brave
	];
	home.stateVersion = "23.11";
}
