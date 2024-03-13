{pkgs, ... }: {
	programs.git = {
		enable = true;
		userName = "mormic04";
		userEmail = "m.morandell@tum.de";
		extraConfig = {
			init.defaultBranch = "main";
		};
	};
}
