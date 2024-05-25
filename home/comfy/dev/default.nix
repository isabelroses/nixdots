{
  lib,
  config,
  ...
}: {
  imports = [
  ];

  programs.git = lib.custom.use {
    includes = [
      {path = "${config.home.homeDirectory}/.dots/gitconfig";}
    ];
  };
  xdg.configFile."git/config".enable = false;
}
