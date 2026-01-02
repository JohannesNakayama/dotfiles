{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.window-manager;
in {
  options.johannes.window-manager.enable = lib.mkEnableOption "Window manager";

  config = lib.mkIf cfg.enable {
    # home.packages = with pkgs; [
    #   i3lock-color
    # ];

    xsession = {
      enable = true;
      windowManager.bspwm = {
        enable = true;
        settings = {
          border_width = 3;
          normal_border_color = "#282433";
          focused_border_color = "#acb0d0";
          window_gap = 0;
          split_ratio = 0.5;
          borderless_monocle = true;
          gapless_monocle = true;
          top_padding = 0;
          bottom_padding = 0;
        };
        monitors = {
          eDP-1 = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];
        };
        # TODO: configure with home manager?
        startupPrograms = [
          "feh --bg-fill $HOME/Pictures/wallpapers/dark/forest-with-fog.jpeg"
          "syncthing --no-browser"
        ];
      };
    };

    services = {
      picom.enable = true;

      sxhkd = {
        enable = true;
        extraOptions = ["-m 1"];
        keybindings = {
          # --- Shortcuts
          "alt + Return" = "alacritty --working-directory $(xcwd)";
          "alt + b" = "brave";
          "alt + t" = "alacritty -e todo";
          "alt + ctrl + t" = "todo spawn";
          "alt + n" = "alacritty -e note";
          "alt + ctrl + n" = "alacritty -e note new";
          "alt + d" = "rofi -show drun"; # launcher
          "alt + f" = "alacritty -e yazi"; # file manager

          # --- Poweroff/reboot
          "ctrl + shift + super + alt + q" = "poweroff";
          "ctrl + shift + super + alt + r" = "reboot";

          # --- Window manager general
          "ctrl + alt + {q,r}" = "bspc {quit,wm -r}"; # quit/restart bspwm
          "alt + {_,shift + }c" = "bspc node -{c,k}"; # close/kill window
          "alt + Escape" = "pkill -USR1 -x sxhkd"; # reload sxhkd config
          "alt + g" = "i3lock -i ~/Pictures/wallpaper.jpg -b -f -C"; # lock screen

          # --- Window management
          "alt + mod3 + {n,t}" = "bspc desktop -f {prev,next}"; # Next/previous desktop
          "super + mod3 + {m,comma,period,n,r,t,h,g,f}" = "bspc desktop -f {1,2,3,4,5,6,7,8,9,10}"; # Navigate to specific desktop
          "alt + {_,shift + }{i,a,l,e}" = "bspc node -{f,s} {west,south,north,east}"; # Focus/shift node in given direction
          "alt + mod5 + {i,a,l,e}" = "bspc node -p {west,south,north,east}"; # Preselect direction
          "super + alt + space" = "bspc node -p cancel"; # Cancel preselection
          "alt + ctrl + {i,a,l,e}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}"; # Expand window
          "alt + shift + ctrl + {i,a,l,e}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}"; # Contract window
          "alt + shift + {n,t}" = "bspc node @/ -C {forward,backward}"; # Rotate tree [1]
          "alt + super + {n,t}" = "id=\$(bspc query --nodes --node); bspc node --to-desktop {prev,next}; bspc desktop --focus next; bspc node --focus \${id}"; # Move focused window to the next workspace and then switch to that workspace [2]

          # --- Window state
          "alt + m" = "bspc desktop -l next"; # toggle tiled/monocle mode
          "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}"; # set the window state
          "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}"; # move a floating window

          # --- Screen brightness
          "XF86MonBrightnessUp" = "brightnessctl set 10%+";
          "XF86MonBrightnessDown" = "brightnessctl set 10%-";

          # "XF86MonBrightnessUp" = "xrandr --output eDP-1 --brightness 1.0"; # bright screen
          # "XF86MonBrightnessDown" = "xrandr --output eDP-1 --brightness 0.5"; # dimmed screen

          # --- Volume
          "XF86AudioLowerVolume" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 0.0";
          "XF86AudioRaiseVolume" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0";
          "XF86AudioMute" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
      };

      polybar = {
        # inspired in part by [3]
        enable = true;
        # TODO: remove once fix is published
        package = (pkgs.polybar.override {pulseSupport = true;}).overrideAttrs (oldAttrs: {
          # This finds all source files and prepends the include header to them
          postPatch =
            (oldAttrs.postPatch or "")
            + ''
              find src include -type f \( -name "*.cpp" -o -name "*.hpp" \) -exec sed -i '1i#include <cstdint>' {} +
            '';
        });
        # config = "~/.config/polybar/config.ini";
        script = "polybar -r main &";
      };

      screen-locker = {
        enable = true;
        lockCmd = "i3lock -i ~/Pictures/wallpaper.jpg -b -f -C";
        inactiveInterval = 5; # minutes
      };
    };
  };
}
# ------------------------------------------------------------------------------
# --- REFERENCES ---------------------------------------------------------------
# ------------------------------------------------------------------------------
# [1] https://my-take-on.tech/2020/07/03/some-tricks-for-sxhkd-and-bspwm/
# [2] https://www.reddit.com/r/bspwm/comments/6jj6le/move_window_to_workspace_and_then_switch_to_that/
# [3] https://github.com/notusknot/dotfiles

