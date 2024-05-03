{pkgs, ...}: {
  home = {
    file = {
      ".xmobarrc".source = ./xmonad/xmobarrc;
      ".xmonadbar".source = ./xmonad/xmonadbar;
    };
  };
  services = {
    picom = {
      enable = true;
      package = with pkgs; picom;
      settings = {
        #################################
        #          Animations           #
        #################################

        transition-length = 10;
        transition-pow-x = 0.1;
        transition-pow-y = 0.1;
        transition-pow-w = 0.1;
        transition-pow-h = 0.1;
        size-transition = true;

        #################################
        #           Fading              #
        #################################

        fading = true;
        fade-in-step = 0.1;
        fade-out-step = 0.1;

        #################################
        #     Background-Blurring       #
        #################################

        blur = {
          method = "kernel";
          strength = 6;
          background = false;
          background-frame = false;
          background-fixed = false;
          kern = "3x3box";
        };

        #################################
        #       General Settings        #
        #################################

        # Daemonize process. Fork to background after initialization. Causes issues with certain (badly-written) drivers.
        # daemon = false

        # Specify the backend to use: `xrender`, `glx`, or `xr_glx_hybrid`.
        # `xrender` is the default one.
        #
        experimental-backends = true;
        backend = "glx";
        #backend = "xrender";

        # Enable/disable VSync.
        vsync = false;
        # vsync = true

        # Enable remote control via D-Bus. See the *D-BUS API* section below for more details.
        # dbus = false

        # Try to detect WM windows (a non-override-redirect window with no
        # child that has 'WM_STATE') and mark them as active.
        #
        # mark-wmwin-focused = false
        mark-wmwin-focused = true;

        # Mark override-redirect windows that doesn't have a child window with 'WM_STATE' focused.
        # mark-ovredir-focused = false
        mark-ovredir-focused = true;

        # Try to detect windows with rounded corners and don't consider them
        # shaped windows. The accuracy is not very high, unfortunately.
        #
        # detect-rounded-corners = false
        detect-rounded-corners = true;

        # Detect '_NET_WM_OPACITY' on client windows, useful for window managers
        # not passing '_NET_WM_OPACITY' of client windows to frame windows.
        #
        # detect-client-opacity = false
        detect-client-opacity = true;

        # Specify refresh rate of the screen. If not specified or 0, picom will
        # try detecting this with X RandR extension.
        #
        refresh-rate = 165;
        # refresh-rate = 0

        # Limit picom to repaint at most once every 1 / 'refresh_rate' second to
        # boost performance. This should not be used with
        #   vsync drm/opengl/opengl-oml
        # as they essentially does sw-opti's job already,
        # unless you wish to specify a lower refresh rate than the actual value.
        #
        # sw-opti =

        # Use EWMH '_NET_ACTIVE_WINDOW' to determine currently focused window,
        # rather than listening to 'FocusIn'/'FocusOut' event. Might have more accuracy,
        # provided that the WM supports it.
        #
        # use-ewmh-active-win = false

        # Unredirect all windows if a full-screen opaque window is detected,
        # to maximize performance for full-screen windows. Known to cause flickering
        # when redirecting/unredirecting windows. paint-on-overlay may make the flickering less obvious.
        #
        unredir-if-possible = false;

        # Delay before unredirecting the window, in milliseconds. Defaults to 0.
        # unredir-if-possible-delay = 0

        # Conditions of windows that shouldn't be considered full-screen for unredirecting screen.
        # unredir-if-possible-exclude = []

        # Use 'WM_TRANSIENT_FOR' to group windows, and consider windows
        # in the same group focused at the same time.
        #
        # detect-transient = false
        detect-transient = true;

        # Use 'WM_CLIENT_LEADER' to group windows, and consider windows in the same
        # group focused at the same time. 'WM_TRANSIENT_FOR' has higher priority if
        # detect-transient is enabled, too.
        #
        detect-client-leader = false;
        # detect-client-leader = true

        # Resize damaged region by a specific number of pixels.
        # A positive value enlarges it while a negative one shrinks it.
        # If the value is positive, those additional pixels will not be actually painted
        # to screen, only used in blur calculation, and such. (Due to technical limitations,
        # with use-damage, those pixels will still be incorrectly painted to screen.)
        # Primarily used to fix the line corruption issues of blur,
        # in which case you should use the blur radius value here
        # (e.g. with a 3x3 kernel, you should use `--resize-damage 1`,
        # with a 5x5 one you use `--resize-damage 2`, and so on).
        # May or may not work with *--glx-no-stencil*. Shrinking doesn't function correctly.
        #
        # resize-damage = 1

        # Specify a list of conditions of windows that should be painted with inverted color.
        # Resource-hogging, and is not well tested.
        #
        # invert-color-include = []

        # GLX backend: Avoid using stencil buffer, useful if you don't have a stencil buffer.
        # Might cause incorrect opacity when rendering transparent content (but never
        # practically happened) and may not work with blur-background.
        # My tests show a 15% performance boost. Recommended.
        #
        # glx-no-stencil = false

        # GLX backend: Avoid rebinding pixmap on window damage.
        # Probably could improve performance on rapid window content changes,
        # but is known to break things on some drivers (LLVMpipe, xf86-video-intel, etc.).
        # Recommended if it works.
        #
        # glx-no-rebind-pixmap = false

        # Disable the use of damage information.
        # This cause the whole screen to be redrawn everytime, instead of the part of the screen
        # has actually changed. Potentially degrades the performance, but might fix some artifacts.
        # The opposing option is use-damage
        #
        # no-use-damage = false
        #use-damage = true (Causing Weird Black semi opaque rectangles when terminal is opened)
        #Changing use-damage to false fixes the problem
        use-damage = false;

        # Use X Sync fence to sync clients' draw calls, to make sure all draw
        # calls are finished before picom starts drawing. Needed on nvidia-drivers
        # with GLX backend for some users.
        #
        # xrender-sync-fence = false

        # GLX backend: Use specified GLSL fragment shader for rendering window contents.
        # See `compton-default-fshader-win.glsl` and `compton-fake-transparency-fshader-win.glsl`
        # in the source tree for examples.
        #
        # glx-fshader-win = ''

        # Force all windows to be painted with blending. Useful if you
        # have a glx-fshader-win that could turn opaque pixels transparent.
        #
        # force-win-blend = false

        # Do not use EWMH to detect fullscreen windows.
        # Reverts to checking if a window is fullscreen based only on its size and coordinates.
        #
        # no-ewmh-fullscreen = false

        # Dimming bright windows so their brightness doesn't exceed this set value.
        # Brightness of a window is estimated by averaging all pixels in the window,
        # so this could comes with a performance hit.
        # Setting this to 1.0 disables this behaviour. Requires --use-damage to be disabled. (default: 1.0)
        #
        # max-brightness = 1.0

        # Make transparent windows clip other windows like non-transparent windows do,
        # instead of blending on top of them.
        #
        # transparent-clipping = false

        # Set the log level. Possible values are:
        #  "trace", "debug", "info", "warn", "error"
        # in increasing level of importance. Case doesn't matter.
        # If using the "TRACE" log level, it's better to log into a file
        # using *--log-file*, since it can generate a huge stream of logs.
        #
        # log-level = "debug"
        log-level = "info";

        # Set the log file.
        # If *--log-file* is never specified, logs will be written to stderr.
        # Otherwise, logs will to written to the given file, though some of the early
        # logs might still be written to the stderr.
        # When setting this option from the config file, it is recommended to use an absolute path.
        #
        # log-file = '/path/to/your/log/file'

        # Show all X errors (for debugging)
        # show-all-xerrors = false

        # Write process ID to a file.
        # write-pid-path = '/path/to/your/log/file'

        # Window type settings
        #
        # 'WINDOW_TYPE' is one of the 15 window types defined in EWMH standard:
        #     "unknown", "desktop", "dock", "toolbar", "menu", "utility",
        #     "splash", "dialog", "normal", "dropdown_menu", "popup_menu",
        #     "tooltip", "notification", "combo", and "dnd".
        #
        # Following per window-type options are available: ::
        #
        #   fade, shadow:::
        #     Controls window-type-specific shadow and fade settings.
        #
        #   opacity:::
        #     Controls default opacity of the window type.
        #
        #   focus:::
        #     Controls whether the window of this type is to be always considered focused.
        #     (By default, all window types except "normal" and "dialog" has this on.)
        #
        #   full-shadow:::
        #     Controls whether shadow is drawn under the parts of the window that you
        #     normally won't be able to see. Useful when the window has parts of it
        #     transparent, and you want shadows in those areas.
        #
        #   redir-ignore:::
        #     Controls whether this type of windows should cause screen to become
        #     redirected again after been unredirected. If you have unredir-if-possible
        #     set, and doesn't want certain window to cause unnecessary screen redirection,
        #     you can set this to `true`.
        #
        wintypes = {
          tooltip = {
            fade = true;
            shadow = true;
            opacity = 1;
            focus = true;
            full-shadow = true;
          };
        };
      };
    };
  };
}
