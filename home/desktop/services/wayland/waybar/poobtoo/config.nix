{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  sys = osConfig.modules.system;
in {
  main-bar = {
    layer = "top";
    position = "top";
    height = 41;
    width = 1280;
    spacing = 0;
    margin-left = 25;
    margin-right = 25;
    margin-bottom = 0;
    margin-top = 0;
    modules-center = ["wlr/workspaces"];
    exclusive = false;
    mode = "overlay";
  };
  "wlr/workspaces" = {
    format = "{icon}";
    on-click = "activate";
    sort-by-number = true;
  };
}
