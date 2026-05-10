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
            openrouter = {
              options = {
                baseURL = "https://openrouter.ai/api/v1";
              };
            };
          };
          # model = "anthropic/claude-sonnet-4-5";
          # model = "openrouter/mistralai/codestral-2508";
          model = "opencode/big-pickle";
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
