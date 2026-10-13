{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.features.custom-scripts;

  isScript = name: type:
    type == "directory" && !lib.hasPrefix "." name && builtins.pathExists (./. + "/${name}/run.sh");

  names = lib.attrNames (lib.filterAttrs isScript (builtins.readDir ./.));

  command = name: let
    dir = ./. + "/${name}";
    deps = dir + "/deps.nix";
  in
    pkgs.writeShellApplication {
      inherit name;
      runtimeInputs = lib.optionals (builtins.pathExists deps) (import deps pkgs);
      text = ''exec ${dir}/run.sh "$@"'';
    };
in {
  options.features.custom-scripts = {
    enable = lib.mkEnableOption "Enable custom scripts";
    scripts = lib.genAttrs names (
      name:
        lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Whether to install the `${name}` command";
        }
    );
  };

  config = lib.mkIf cfg.enable {
    home.packages = map command (lib.filter (name: cfg.scripts.${name}) names);
  };
}
