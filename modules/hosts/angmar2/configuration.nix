{ self, inputs, ... }: {

  flake.nixosModules.angmar2Config = { pkgs, lib, ... }: {

    imports = [
      self.nixosModules.angmar2Hardware
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
  
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "angmar2"; 
    networking.networkmanager.enable = true;
      
    time.timeZone = "America/Chicago";
      
    users.users.xander = {
      shell = pkgs.zsh;
	isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        packages = with pkgs; [
          tree
        ];
    };
      
    programs.firefox.enable = true;
    programs.zsh.enable = true; 
      
    environment.systemPackages = with pkgs; [
      #TUI
      neovim
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
      spotify
      steam
      telegram-desktop
      zed-editor
      #REQ
      mako
      wget
      git
      font-awesome
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
    security.pam.services.swaylock = {};
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
      
    system.stateVersion = "25.11";
  };
}
