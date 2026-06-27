{ self, inputs, ... }: {

  flake.nixosModules.angmar2Config = { pkgs, lib, ... }: {

    imports = [
      self.nixosModules.angmar2Hardware
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nixpkgs.config.allowUnfree = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "angmar2";
    networking.networkmanager.enable = true;

    time.timeZone = "America/Chicago";

    users.users.xander = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" ]; 
      packages = with pkgs; [
        #TUI
        tree
        zig
        zls
        fzf
        neovim
        zk
        nixd
        nixfmt
        vim
        bat
        yazi
        btop
        opencode
        ffmpeg
        #GUI
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ghostty
        anytype
        gimp
        vlc
        keymapp
        obs-studio
        steam
        telegram-desktop
        zed-editor
        discord
      ];
    };
    home-manager.users.xander = self.homeModules.xanderModule;

    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
      #REQ
      vim
      azure-cli
	  cifs-utils
      mako
      ripgrep
      wget
      git
      font-awesome
      brightnessctl
      xwayland-satellite
      xwayland
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      gnome-keyring
    ];

    environment.variables.EDITOR = "nvim";

    services.upower.enable = true;
    services.tuned.enable = true;
    services.logind.settings.Login = {
      HandleLidSwitch = "lock";
      HandleLidSwitchExternalPower = "lock";
      HandleLidSwitchDocked = "ignore";
    };
    services.thermald.enable = true;
    services.displayManager.ly.enable = true;
    services.tailscale.enable = true;
    services.libinput.enable = true;
    services.printing.enable = true;
    services.fprintd.enable = true;
    security.pam.services.swaylock = { };
    security.pam.services.swaylock.fprintAuth = true;
    services.xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
    };
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    fonts.packages = with pkgs; [
      cantarell-fonts
      nerd-fonts.jetbrains-mono
    ];

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
	fileSystems."/mnt/share" = {
	  device = "//100.125.11.72/srv/shares";
	  fsType = "cifs";
	  options = let
		automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
	  in ["${automount_opts},credentials=/home/xander/nixos2/smb-secrets,uid=1000,guid=100"];
	};

    system.stateVersion = "25.11";
  };
}
