{ self, inputs, ... }: {

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.xander = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.xanderModule
      {
        home.username = "xander";
        home.homeDirectory = "/home/xander";
      }
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules.xanderModule = { pkgs, ... }: {
	  programs.zsh = {
		enable = true; 
		shellAliases = {
		  ll = "ls -l";
		  btw = "echo nixos btw";
		  update = "sudo nixos-rebuild switch --flake .#angmar2";
		};
		oh-my-zsh = {
		  enable = true;
		  theme = "cypher";
		};
		initContent = ''
		  eval "$(tirith init --shell zsh)"
		'';
	  };
	  
	  programs.git = {
	    enable = true;
		settings = {
		  user = {
			name = "xandalf-dot";
			email = "xkeele7@gmail.com";
		  };
		  init.defaultBranch = "main";
		};
	  };

	  home.packages = [ pkgs.hello ];
	  home.stateVersion = "25.11";
  };

}
