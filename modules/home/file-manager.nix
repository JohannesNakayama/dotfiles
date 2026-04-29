{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.file-manager;
in {
  options.johannes.file-manager.enable = lib.mkEnableOption "File manager";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        chafa
        ueberzugpp
      ];

      sessionVariables = {
        PISTOL_CHROMA_STYLE = "evergarden";
      };
    };

    programs = {
      yazi = {
        enable = true;
        shellWrapperName = "y";
      };

      pistol = {
        enable = true;
        associations = [
          {
            mime = "image/*";
            command = "chafa --fit-width --view-size=80x120 %pistol-filename%";
          }
        ];
      };
    };
  };
}
