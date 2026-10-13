{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.johannes.ai;
  piNonoProfileName = "pi-custom";
in {
  options.johannes.ai.enable = lib.mkEnableOption "AI";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.nono # sandbox for AI agents
      pkgs.opencode-claude-auth # connect opencode with claude
    ];

    programs = {
      opencode = {
        enable = true;
        settings = {
          provider = {
            anthropic.options.baseURL = "https://api.anthropic.com/v1";
            openrouter.options.baseURL = "https://openrouter.ai/api/v1";
            local = {
              name = "Local Llama Server";
              package = "@ai-sdk/openai-compatible";
              options = {
                baseURL = "http://127.0.0.1:8080/v1";
                apiKey = "mock-api-key";
              };
              models = {
                "qwen35" = {
                  name = "Qwen 3.5 35B A3B (Local)";
                };
              };
            };
          };
          plugin = ["opencode-claude-auth"];

          model = "anthropic/claude-sonnet-5";
          # model = "local/qwen3.5-35b"; # local llama-cpp has to be running
        };
      };

      pi-coding-agent = {
        enable = true;
        models = {
          providers = {
            llama-cpp = {
              baseUrl = "http://localhost:8080/v1";
              api = "openai-completions";
              apiKey = "mock-api-key"; # required to be set, but contents don't matter
              models = [
                {id = "qwen35";}
              ];
            };
          };
        };
        settings = {
          defaultProvider = "claude-bridge";
          defaultModel = "claude-opus-5-5";
          packages = [
            "git:github.com/fdietze/pi-infinite-context"
            # "git:github.com/pankajudhas81/pi-claude-auth"
            "git:github.com/elidickinson/pi-claude-bridge"
          ];
        };
      };

      claude-code.enable = true;
    };

    xdg.configFile."nono/profiles/${piNonoProfileName}.json".text = builtins.toJSON {
      meta.name = piNonoProfileName;
      extends = "nolabs-ai/pi";
      filesystem = {
        read = [
          "${config.home.homeDirectory}/.claude"
          "/tmp/jiti"
        ];
        write = [
          "/tmp/jiti"
          "${config.home.homeDirectory}/.npm"
        ];
      };
    };

    home.shellAliases = {
      pi = "nono run --profile ${piNonoProfileName} --allow-cwd -- pi";
    };
  };
}
