{
  config,
  lib,
  pkgs,
  home,
  ...
}: {
  home = {
    packages = with pkgs; [
      glib # required for gsettings
      config.gtk.theme.package
      config.gtk.iconTheme.package
    ];
    sessionVariables = {
      GTK_THEME = config.gtk.theme.name;
      GDK_PIXBUF_MODULE_FILE = "$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)"; # required for loading svg icons
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      # name = "Papirus";
      # package = pkgs.papirus-icon-theme;
      name = "gruvbox-plus";
      package = pkgs.gruvbox-plus;
    };

    font = {
      name = "JetBrainsMono NF";
      size = 11;
    };

    gtk2 = {
      configLocation = "${config.home.homeDirectory}/.gtkrc-2.0";
      extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
      '';
    };

    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.file.".config/gtk-4.0/gtk.css" = {
    enable = true;
    text = ''
      @define-color accent_color #83a598;
      @define-color accent_bg_color mix(#83a598, #282828,0.3);
      @define-color accent_fg_color #d5c4a1;
      @define-color destructive_color #83a598;
      @define-color destructive_bg_color mix(#83a598, #282828,0.3);
      @define-color destructive_fg_color #d5c4a1;
      @define-color success_color #8ff0a4;
      @define-color success_bg_color #26a269;
      @define-color success_fg_color #d5c4a1;
      @define-color warning_color #f8e45c;
      @define-color warning_bg_color #cd9309;
      @define-color warning_fg_color rgba(0, 0, 0, 0.8);
      @define-color error_color #ff7b63;
      @define-color error_bg_color mix(#83a598, #282828,0.3);
      @define-color error_fg_color #d5c4a1;
      @define-color window_bg_color #282828;
      @define-color window_fg_color #d5c4a1;
      @define-color view_bg_color #3c3836;
      @define-color view_fg_color #d5c4a1;
      @define-color headerbar_bg_color mix(#282828,black,0.2);
      @define-color headerbar_fg_color #d5c4a1;
      @define-color headerbar_border_color #d5c4a1;
      @define-color headerbar_backdrop_color @window_bg_color;
      @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
      @define-color card_bg_color rgba(255, 255, 255, 0.08);
      @define-color card_fg_color #d5c4a1;
      @define-color card_shade_color rgba(0, 0, 0, 0.36);
      @define-color dialog_bg_color #665c54;
      @define-color dialog_fg_color #d5c4a1;
      @define-color popover_bg_color #665c54;
      @define-color popover_fg_color #d5c4a1;
      @define-color shade_color rgba(0,0,0,0.36);
      @define-color scrollbar_outline_color rgba(0,0,0,0.5);
      @define-color blue_1 #83a598;
      @define-color blue_2 #83a598;
      @define-color blue_3 #83a598;
      @define-color blue_4 #83a598;
      @define-color blue_5 #83a598;
      @define-color green_1 #b8bb26;
      @define-color green_2 #b8bb26;
      @define-color green_3 #b8bb26;
      @define-color green_4 #b8bb26;
      @define-color green_5 #b8bb26;
      @define-color yellow_1 #fabd2f;
      @define-color yellow_2 #fabd2f;
      @define-color yellow_3 #fabd2f;
      @define-color yellow_4 #fabd2f;
      @define-color yellow_5 #fabd2f;
      @define-color orange_1 #fe8019;
      @define-color orange_2 #fe8019;
      @define-color orange_3 #fe8019;
      @define-color orange_4 #fe8019;
      @define-color orange_5 #fe8019;
      @define-color red_1 #fb4934;
      @define-color red_2 #fb4934;
      @define-color red_3 #fb4934;
      @define-color red_4 #fb4934;
      @define-color red_5 #fb4934;
      @define-color purple_1 #d3869b;
      @define-color purple_2 #d3869b;
      @define-color purple_3 #d3869b;
      @define-color purple_4 #d3869b;
      @define-color purple_5 #d3869b;
      @define-color brown_1 #d65d0e;
      @define-color brown_2 #d65d0e;
      @define-color brown_3 #d65d0e;
      @define-color brown_4 #d65d0e;
      @define-color brown_5 #d65d0e;
      @define-color light_1 #d5c4a1;
      @define-color light_2 #f6f5f4;
      @define-color light_3 #deddda;
      @define-color light_4 #c0bfbc;
      @define-color light_5 #9a9996;
      @define-color dark_1 mix(#282828,white,0.5);
      @define-color dark_2 mix(#282828,white,0.2);
      @define-color dark_3 #282828;
      @define-color dark_4 mix(#282828,black,0.2);
      @define-color dark_5 mix(#282828,black,0.4);
    '';
  };
  home.file.".config/gtk-3.0/gtk.css" = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/gtk-4.0/gtk.css";
  };

  home.file.".themes" = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-profile/share/themes";
  };
}
