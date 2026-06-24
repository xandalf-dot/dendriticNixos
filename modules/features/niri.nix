{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs; 
        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.myNoctalia)
			(lib.getExe pkgs.ghostty)
			(lib.getExe inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default)
          ];

          hotkey-overlay.skip-at-startup = _: { };

          prefer-no-csd = _: { };

          input.keyboard.xkb.layout = "us,ua";
          input.touchpad.natural-scroll = _: { };
          input.touchpad.tap = _: { };

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
          layout.border.off = _: { };
          layout.focus-ring.width = 1;

		  layout.tab-indicator.position = "bottom";
		  layout.tab-indicator.gap = -3;
          animations.slowdown = 0.7;

		  window-rules = [
			{
			  matches = [
				{ app-id = "zen"; }
			  ];
			  open-on-workspace = "b";
			  open-maximized = true;
			}
		  ];

          binds = {
            "Mod+T".spawn-sh = lib.getExe pkgs.ghostty;
            "Ctrl+Alt+Delete".quit = _: { };
            "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
            "Mod+O".toggle-overview = _: { };

            "Print".screenshot = _: { };
            "Mod+Shift+Ctrl+S".screenshot-screen = _: { };
            "Mod+Shift+Alt+S".screenshot-window = _: { };

            "Mod+Q".close-window = _: { };
            "Mod+F".maximize-column = _: { };
            "Mod+G".fullscreen-window = _: { };
            "Mod+Shift+F".toggle-window-floating = _: { };
            "Mod+C".center-column = _: { };

			"Mod+BracketLeft".consume-or-expel-window-left = _: {};
			"Mod+BracketRight".consume-or-expel-window-right = _: {};
			"Mod+W".toggle-column-tabbed-display = _: {};

			"Mod+Minus".set-column-width = "-10";
			"Mod+Equal".set-column-width = "+10";
			
            "Mod+H".focus-column-or-monitor-left = _: { };
            "Mod+L".focus-column-or-monitor-right = _: { };
            "Mod+K".focus-window-or-monitor-up = _: { };
            "Mod+J".focus-window-or-monitor-down = _: { };

            "Mod+Shift+H".move-column-left = _: { };
            "Mod+Shift+L".move-column-right = _: { };
            "Mod+Shift+K".move-window-up = _: { };
            "Mod+Shift+J".move-window-down = _: { };

            "Mod+Shift+Ctrl+H".move-workspace-to-monitor-left = _: { };
            "Mod+Shift+Ctrl+L".move-workspace-to-monitor-right = _: { };
            "Mod+Shift+Ctrl+K".move-workspace-to-monitor-up = _: { };
            "Mod+Shift+Ctrl+J".move-workspace-to-monitor-down = _: { };

            "Mod+1".focus-workspace = "1";
			"Mod+B".focus-workspace = "B";
            "Mod+2".focus-workspace = "2";
            "Mod+3".focus-workspace = "3";
            "Mod+4".focus-workspace = "4";
            "Mod+5".focus-workspace = "5";
            "Mod+6".focus-workspace = "6";
            "Mod+7".focus-workspace = "7";
            "Mod+8".focus-workspace = "8";
            "Mod+9".focus-workspace = "9";
            "Mod+0".focus-workspace = "0";
            "Mod+Ctrl+1".move-column-to-workspace = "1";
			"Mod+Ctrl+B".move-column-to-workspace = "B";
            "Mod+Ctrl+2".move-column-to-workspace = "2";
            "Mod+Ctrl+3".move-column-to-workspace = "3";
            "Mod+Ctrl+4".move-column-to-workspace = "4";
            "Mod+Ctrl+5".move-column-to-workspace = "5";
            "Mod+Ctrl+6".move-column-to-workspace = "6";
            "Mod+Ctrl+7".move-column-to-workspace = "7";
            "Mod+Ctrl+8".move-column-to-workspace = "8";
            "Mod+Ctrl+9".move-column-to-workspace = "9";
            "Mod+Ctrl+0".move-column-to-workspace = "0";

            "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
            "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
            "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "XF86AudioMicMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
			"XF86MonBrightnessDown".spawn-sh = "brightnessctl --class=backlight set 10%-";
			"XF86MonBrightnessUp".spawn-sh = "brightnessctl --class=backlight set +10%"; 
          };

          workspaces =
            {
              "1" = _: {};
              "B" = _: {};
              "2" = _: {};
              "3" = _: {};
              "4" = _: {};
              "5" = _: {};
              "6" = _: {};
              "7" = _: {};
              "8" = _: {};
              "9" = _: {};
              "0".open-on-output = "DP-5";
            };
        };
      };
    };
}
