{ pkgs
, options
, config
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.audio;
in
{
  options.hardware.audio = with types; {
    enable = mkBoolOpt false "Enable pipewire";
  };

  config = mkIf cfg.enable {
    # sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
      jack.enable = false;
      pulse.enable = true;
    };
    programs.noisetorch.enable = true;
    environment.systemPackages = with pkgs; [
      easyeffects
      pavucontrol
    ];
  };
}
