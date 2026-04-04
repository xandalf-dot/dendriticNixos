{ self, inputs, ... }: {

    flake.nixosModules.xanderHome = { pkgs, lib, ... }: {
	
	imports = [
	    self.home-manager.flakeModules.home-manager
	];
     	
    home.username = "xander";
    home.homeDirectory = "/home/xander";
    home.stateVersion = "25.11";
    home.packages = with pkgs; [
        neovim
	luarocks
	lua
	zk
	vimPlugins.nvim-treesitter
        fzf
	ripgrep
	fd
	fastfetch
	brightnessctl
	playerctl
	libnotify
	ffmpeg
	#TUI
	bat
	audible-cli
	yazi
	wiremix
	btop
	opencode
	#hacking
	maigret
	nmap
	wireshark
	metasploit
	aircrack-ng
	hashcat
	hashcat-utils
	sqlmap
	hping
	thc-hydra
	john
	#GUI 
	discord
	anytype
	fluffychat
	vlc
	gimp
	keymapp
	obs-studio
	spotify
	spotify-player
	steam
	telegram-desktop
	zed-editor
    ];
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
