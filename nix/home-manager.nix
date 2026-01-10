{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.yamusic-tui-enhanced;
in
{
  options.programs.yamusic-tui-enhanced = {
    enable = lib.mkEnableOption "Yandex Music TUI client";

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Yamusic configuration";
    };

    configPath = lib.mkOption {
      type = lib.types.str;
      default = "yamusic-tui/config.yaml";
      description = "Relative path inside XDG config dir";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (import ./default.nix { inherit pkgs; })
    ];

    xdg.configFile.${cfg.configPath}.text = lib.generators.toYAML { } cfg.settings;
  };
}
