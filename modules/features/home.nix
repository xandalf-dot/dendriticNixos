{ self, inputs, ... }: {

    flake.nixosModules.xanderHome = { pkgs, lib, ... }: {
	
	imports = [
	    self.home-manager.flakeModules.home-manager
	];
     	
    home.username = "xander";
    home.homeDirectory = "/home/xander";
    home.stateVersion = "25.11";
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

    programs.zsh = {
      enable = true;
      shellAliases = {
        ll="ls -l";
        btw = "echo nixos btw";
	update = "sudo nixos-rebuild switch";
      };
      oh-my-zsh = {
        enable = true;
	theme = "cypher";
      };
      initContent = ''
        eval "$(tirith init --shell zsh)"
      '';
    };
    };  
}
