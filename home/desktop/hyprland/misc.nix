_: {
  wayland.windowManager.hyprland = {
    settings = {

      render = {
        direct_scanout = 1;
      };

      misc = {
        vfr = true; # misc:no_vfr -> misc:vfr. bool, heavily recommended to leave at default on. Saves on CPU usage.
        vrr = 1; # misc:vrr -> Adaptive sync of your monitor. 0 (off), 1 (on), 2 (fullscreen only). Default 0 to avoid white flashes on select hardware.
        disable_hyprland_logo = true;
      };

      debug = {
        damage_tracking = 2; # leave it on 2 (full) unless you hate your GPU and want to make it suffer!
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
    };
  };
}
