{
	description = "mormics flake";
	
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "nixpkgs/nixos-23.11";
		
		home-manager.url = "github:nix-community/home-manager/master";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		stylix.url = "github:danth/stylix";

		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			flake = false;
		};

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      flake = false;
    };

	};

	outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, stylix, hyprland-plugins, sddm-sugar-candy, ... }:
  let
    
    systemSettings = {
      system = "x86_64-linux";
      #select profile
      profile = "nixdesk";
      #profile = "nixnote";
      #profile = "nixserv";
      hostname = "nixdesk";
      timezone = "Europe/Berlin";
      locale_us = "en_US.UTF-8";
      locale_de = "de_DE.UTF-8";
    };

    userSettings = rec {
      username = "user";
      name = "MacKenzie779";
      email = "MacKenzie779@proton.me";
      #dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
      
      # selcted theme from my themes directory (./themes/)
	    theme = "nord";

			# Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
      wm = "hyprland"; 
      # window manager type (hyprland or x11) translator
      wmType = if (wm == "hyprland") then "wayland" else "x11";
      browser = "brave"; # Default browser; must select one from ./user/app/browser/
      term = "alacritty"; # Default terminal command;
      font = "Intel One Mono"; # Selected font
      fontPkg = pkgs.intel-one-mono; # Font package
      editor = "vim"; # Default editor;
      # editor spawning translator
      # generates a command that can be used to spawn editor inside a gui
      # EDITOR and TERM session variables must be set in home.nix or other module
      # I set the session variable SPAWNEDITOR to this in my home.nix for convenience
      spawnEditor = if (editor == "emacsclient") then "emacsclient -c -a 'emacs'"
                    else (if ((editor == "vim") || (editor == "nvim") || (editor == "nano")) then "exec " + term + " -e " + editor else editor);
    };          

    # default pkgs = unstable
    pkgs = import nixpkgs {
      system = systemSettings.system;
      config = { 
				allowUnfree = true;
				allowUnfreePredicate = (_: true); 
			};
    };

		# stable pkgs
    pkgs-stable = import nixpkgs-stable {
      system = systemSettings.system;
      config = { 
				allowUnfree = true;
				allowUnfreePredicate = (_: true); 
			};
    };

    # configure lib
    lib = nixpkgs.lib;

    supportedSystems = [
      "x86_64-linux"
    ];

    # Function to generate a set based on supported systems:
    forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;

    # Attribute set of nixpkgs for each system:
    nixpkgsFor = forAllSystems(system: import inputs.nixpkgs { inherit system; });

  in {

    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
					(./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix") # load home.nix from selected PROFILE
        ];
        extraSpecialArgs = {
          # pass config variables from above
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
          inherit (inputs) stylix;
          inherit (inputs) hyprland-plugins;
        };
      };
    };

    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [ 
					(./. + "/profiles"+("/"+systemSettings.profile)+"/configuration.nix") 
				]; # load configuration.nix from selected PROFILE
        specialArgs = {
          # pass config variables from above
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
          inherit (inputs) stylix;
        };
      };
    };

#    packages = forAllSystems (system:
 #     let 
	#			pkgs = nixpkgsFor.${system}; 
	#		in {
   #     default = self.packages.${system}.install;
    #    install = pkgs.writeScriptBin "install" ./install.sh;
     # }
#		);
#
 #   apps = forAllSystems (system: {
  #    default = self.apps.${system}.install;
   #   install = {
    #    type = "app";
     #   program = "${self.packages.${system}.install}/bin/install";
#      };
 #   });
  };
}
