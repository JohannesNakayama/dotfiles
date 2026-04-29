{
  config,
  lib,
  ...
}: let
  cfg = config.johannes.ai;
in {
  options.johannes.ai.enable = lib.mkEnableOption "AI";

  config = lib.mkIf cfg.enable {
    programs = {
      opencode = {
        enable = true;
        settings = {
          provider = {
            anthropic = {
              options = {
                baseURL = "https://api.anthropic.com/v1";
              };
            };
          };
          model = "anthropic/claude-sonnet-4-5";
          permission = {
            bash = "ask";
            edit = "allow";
            glob = "allow";
            grep = "allow";
            lsp = "allow";
            read = "allow";
            skill = "allow";
            todowrite = "allow";
            webfetch = "ask";
            websearch = "allow";
            question = "allow";
          };
        };
      };
    };
  };
}
