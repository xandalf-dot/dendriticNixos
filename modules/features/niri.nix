{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        hotkey-overlay.skip-at-startup = _: {};

	prefer-no-csd = _: {};

        input.keyboard.xkb.layout = "us,ua";
        input.touchpad.natural-scroll = _: {};
        input.touchpad.tap = _: {};

        
	outputs = {
	  "eDP-1" = {
	    position = _: {
	      props = {
	        x = 0;
	        y = 0;
	      };
	    };
	    hot-corners = {
	      off = { };
	    };
	    mode = "1920x1080@60.033";
	  };
	  "DP-1" = {
	    mode = "1920x1080@165.003";
	    hot-corners = {
	      off = { };
	    };
	  };
	  "DP-2" = {
	    mode = "1920x1080@165.003";
	    hot-corners = {
	      off = { };
	    };
	  };
	  "DP-3" = {
	    mode = "1920x1080@165.003";
	    hot-corners = {
	      off = { };
	    };
	  };
	  "DP-4" = {
	    mode = "1920x1080@165.003";
	    hot-corners = {
	      off = { };
	    };
	  };
	  "DP-5" = {
	    mode = "1920x1080@165.003";
	    position = _: {
	      props = {
	        x = 0;
		y = -1080;
	      };
	    };
	    hot-corners = {
	      off = { };
	    };
	    # transform = "270";
	  };
	  "DP-6" = {
	    mode = "1920x1080@165.003";
	    position = _: {
	      props = {
	        x = 1920;
	        y = -1640;
	      };
	    };
	    hot-corners = {
	      off = { };
	    };
	    transform = "270";
	  };
	};
	

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        layout.gaps = 5;
	layout.border.width = 1;
	layout.border.off = _: {};
	layout.focus-ring.width = 1;

	animations.slowdown = 0.7;

        binds = {
          "Mod+T".spawn-sh = lib.getExe pkgs.ghostty;
	  "Ctrl+Alt+Delete".quit = _: {};

	  "Print".screenshot = _: {};
	  "Mod+Shift+Ctrl+S".screenshot-screen = _: {};
	  "Mod+Shift+Alt+S".screenshot-window = _: {};

	  "Mod+Q".close-window = _: {};
          "Mod+F".maximize-column = _: {};
          "Mod+G".fullscreen-window = _: {};
          "Mod+Shift+F".toggle-window-floating = _: {};
          "Mod+C".center-column = _: {};

          "Mod+H".focus-column-or-monitor-left = _: {};
          "Mod+L".focus-column-or-monitor-right = _: {};
          "Mod+K".focus-window-or-monitor-up = _: {};
          "Mod+J".focus-window-or-monitor-down = _: {};

          "Mod+Left".focus-column-left = _: {};
          "Mod+Right".focus-column-right = _: {};
          "Mod+Up".focus-window-up = _: {};
          "Mod+Down".focus-window-down = _: {};

          "Mod+Shift+H".move-column-left = _: {};
          "Mod+Shift+L".move-column-right = _: {};
          "Mod+Shift+K".move-window-up = _: {};
          "Mod+Shift+J".move-window-down = _: {};

          "Mod+1".focus-workspace = "w0";
          "Mod+2".focus-workspace = "w1";
          "Mod+3".focus-workspace = "w2";
          "Mod+4".focus-workspace = "w3";
          "Mod+5".focus-workspace = "w4";
          "Mod+6".focus-workspace = "w5";
          "Mod+7".focus-workspace = "w6";
          "Mod+8".focus-workspace = "w7";
          "Mod+9".focus-workspace = "w8";
          "Mod+0".focus-workspace = "w9";
	  "Mod+Ctrl+1".move-column-to-workspace = "w0";
          "Mod+Ctrl+2".move-column-to-workspace = "w1";
          "Mod+Ctrl+3".move-column-to-workspace = "w2";
          "Mod+Ctrl+4".move-column-to-workspace = "w3";
          "Mod+Ctrl+5".move-column-to-workspace = "w4";
          "Mod+Ctrl+6".move-column-to-workspace = "w5";
          "Mod+Ctrl+7".move-column-to-workspace = "w6";
          "Mod+Ctrl+8".move-column-to-workspace = "w7";
          "Mod+Ctrl+9".move-column-to-workspace = "w8";
          "Mod+Ctrl+0".move-column-to-workspace = "w9";

          "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
	  "Mod+O".toggle-overview = _: {};
	  
          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
	  "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
	  "XF86AudioMicMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };

	workspaces = let
          settings = {};
        in {
          "w0" = settings;
          "w1" = settings;
          "w2" = settings;
          "w3" = settings;
          "w4" = settings;
          "w5" = settings;
          "w6" = settings;
          "w7" = settings;
          "w8" = settings;
          "w9" = settings;
        };
      };
    };
  };
}
