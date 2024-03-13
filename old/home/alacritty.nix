{...}: {
	programs.alacritty = {
		enable = true;
		settings = {
			#env.TERM = "xterm-256color";
			window = {
				title = "Alacritty";
				#dynamic_title = false;
			};
		};
	};
}

