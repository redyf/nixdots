_: {
  wayland.windowManager.hyprland = {
    settings = {
      config = {
        render = {
          direct_scanout = 1;
        };

        misc = {
          vrr = 1;
          disable_hyprland_logo = true;
        };

        debug = {
          damage_tracking = 2;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };
      };
    };
  };
}
