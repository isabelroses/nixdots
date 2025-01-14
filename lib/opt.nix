{lib, ...}: let
  inherit (lib) mkOption types;
in rec {
  # mkOpt type default desc
  mkOpt = type: default: description:
    mkOption {inherit type default description;};

  # mkOpt' type default
  mkOpt' = type: default: mkOpt type default null;

  # mkBoolOpt default desc
  mkBoolOpt = mkOpt types.bool;

  # mkBoolOpt' default
  mkBoolOpt' = mkOpt' types.bool;

  # mkEnableOpt name
  mkEnableOpt = name: mkBoolOpt false "enable ${name}";

  mkOptions = desc: o:
    {
      enable = mkBoolOpt false desc;
    }
    // o;

  enabled = {enable = true;};
  disabled = {enable = false;};

  use = o: enabled // o;
}
