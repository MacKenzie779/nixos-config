{ lib, home-manager, pkgs, ... }: {
	
	users.users.user = {
		isNormalUser = true;
		description = "user";
		extraGroups = [ "wheel" "networkmanager" ];
	};

	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		users.user = import ./home.nix;
	};
}
