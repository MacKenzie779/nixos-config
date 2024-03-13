{pkgs, ... }: {
	home.packages = with pkgs; [
		libreoffice
		hunspell
	]
	++ (with pkgs.hunspellDicts; [
		de_DE
		en_US
		it_IT
	]);
}
