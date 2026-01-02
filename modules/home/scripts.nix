{pkgs, ...}: let
  cfg = config.johannes.scripts;
in {
  options.johannes.scripts.enable = lib.mkEnableOption "Scripts";

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "backup" (builtins.readFile ../scripts/backup))
      (pkgs.writeShellScriptBin "byebye" (builtins.readFile ../scripts/byebye))
      (pkgs.writeShellScriptBin "cfg" (builtins.readFile ../scripts/cfg))
      (pkgs.writeShellScriptBin "note" (builtins.readFile ../scripts/note))
      (pkgs.writeShellScriptBin "post" (builtins.readFile ../scripts/post))
      (pkgs.writeShellScriptBin "recipe" (builtins.readFile ../scripts/recipe))
      (pkgs.writeShellScriptBin "shop" (builtins.readFile ../scripts/shop))
      (pkgs.writeShellScriptBin "tb" (builtins.readFile ../scripts/tb))
      (pkgs.writeShellScriptBin "tigd" (builtins.readFile ../scripts/tigd))
      (pkgs.writeShellScriptBin "todo" (builtins.readFile ../scripts/todo))
      (pkgs.writeShellScriptBin "v" (builtins.readFile ../scripts/v))
      (pkgs.writeShellScriptBin "wallpaper" (builtins.readFile ../scripts/wallpaper))
    ];
  };
}
