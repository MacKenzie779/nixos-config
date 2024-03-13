{ pkgs,  nixpkgs, ... }: {

	programs.fish.enable = true;
	users.defaultUserShell = pkgs.fish;

	environment.systemPackages = with pkgs; [
		wget
		vim
		neovim
		htop
		btop
		nix-tree
		zip
		nnn
		neofetch
		vscode

	];
	
	nix = {
		gc = {
			automatic = true;
			dates = "05:30";
			options = "--delete-older-than-3d";
		};
		settings = {
			keep-outputs = true;
			auto-optimise-store = true;
			experimental-features = [ "nix-command" "flakes" "repl-flake"];
			trusted-users = [ "root" "@wheel" ];
		};
	};
	system.stateVersion = "23.11";	
}
