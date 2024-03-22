{pkgs, inputs, ...}:

let 

hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
#plugins = inputs.hyprland-plugins.packages.${pkgs.system};

#playerctl = "${pkgs.playerctl}/bin/playerctl";
#brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
#pactl = "${pkgs.pulseaudio}/bin/pactl";

in
{

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
       

       exec-once = "asztal";
       env = "XCURSOR_SIZE,24";
      "$mainMod" = "SUPER";

      input = {
        kb_layout = "br";
        follow_mouse = 2;
        touchpad = {
          natural_scroll = "no";
        };
      };


      general = {
        gaps_in = 4;
        gaps_out = 15;
        border_size = 2;
        "col.active_border" = " rgba(33ccffee) rgba(00ff99ee) 45deg";
        # active_border = " rgba(595959aa)";

        layout = "dwindle";
        allow_tearing = false;
      };


      decoration = {
        rounding = 3;
        blur = {
          enabled = true;
          size = 4;
          passes = 4;
          new_optimizations = true;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };


      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
        ];
      };


      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "yes"; # you probably want this
      };


      master = {
          new_is_master = true;
      };


      gestures = {
        workspace_swipe = "off";
      };


      misc = {
        force_default_wallpaper = -1;
      };


      bind = [
        "$mainMod, Return, exec, kitty"
        "$mainMod, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, dolphin"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, wofi --show drun"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, B, exec, firefox"

        # move focus with mainMod + arrow keys 
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus"

        # switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10" 

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      
        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

      ];


      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

    };
    
  };

}


