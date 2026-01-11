{
  inputs,
  lib,
  config,
  homeDirectory,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];
  options = {
    noctalia.enable = lib.mkEnableOption "Enable Noctalia Shell module";
  };
  config = lib.mkIf config.noctalia.enable {
    programs.noctalia-shell = {
      enable = true;
      settings = {
        appLauncher = {
          customLaunchPrefix = "";
          customLaunchPrefixEnabled = false;
          enableClipboardHistory = false;
          pinnedExecs = [ ];
          position = "center";
          sortByMostUsed = true;
          terminalCommand = "xterm -e";
          useApp2Unit = false;
        };

        audio = {
          cavaFrameRate = 60;
          mprisBlacklist = [ ];
          preferredPlayer = "";
          visualizerType = "linear";
          volumeOverdrive = false;
          volumeStep = 5;
        };

        bar = {
          density = "compact";
          floating = false;
          marginHorizontal = 0.25;
          marginVertical = 0.25;
          monitors = [ ];
          position = "bottom";
          showCapsule = true;
          outerCorners = false;
          widgets = {
            center = [
              {
                characterCount = 2;
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "name";
              }
            ];

            left = [
              {
                id = "SystemMonitor";
                showCpuTemp = true;
                showCpuUsage = true;
                showDiskUsage = false;
                showMemoryAsPercent = false;
                showMemoryUsage = true;
                showNetworkStats = false;
              }
              {
                colorizeIcons = false;
                hideMode = "hidden";
                id = "ActiveWindow";
                maxWidth = 145;
                scrollingMode = "hover";
                showIcon = true;
                useFixedWidth = false;
              }
              {
                hideMode = "hidden";
                id = "MediaMini";
                maxWidth = 145;
                scrollingMode = "hover";
                showAlbumArt = false;
                showVisualizer = false;
                useFixedWidth = false;
                visualizerType = "linear";
              }
            ];

            right = [
              { id = "ScreenRecorder"; }
              {
                blacklist = [ ];
                colorizeIcons = false;
                id = "Tray";
              }
              {
                hideWhenZero = true;
                id = "NotificationHistory";
                showUnreadBadge = true;
              }
              {
                displayMode = "onhover";
                id = "Battery";
                warningThreshold = 30;
              }
              {
                displayMode = "onhover";
                id = "Volume";
              }
              {
                displayMode = "onhover";
                id = "Brightness";
              }
              {
                customFont = "";
                formatHorizontal = "HH:mm ddd, MMM dd";
                formatVertical = "HH mm - dd MM";
                id = "Clock";
                useCustomFont = false;
                usePrimaryColor = true;
              }
              {
                customIconPath = "";
                icon = "noctalia";
                id = "ControlCenter";
                useDistroLogo = false;
              }
            ];
          };
        };

        battery = {
          chargingMode = 0;
        };

        brightness = {
          brightnessStep = 5;
          enforceMinimum = true;
        };

        colorSchemes = {
          darkMode = true;
          generateTemplatesForPredefined = true;
          manualSunrise = "06:30";
          manualSunset = "18:30";
          matugenSchemeType = "scheme-fruit-salad";
          predefinedScheme = "Tokyo Night";
          schedulingMode = "off";
          useWallpaperColors = false;
        };

        controlCenter = {
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = true;
              id = "shortcuts-card";
            }
            {
              enabled = true;
              id = "audio-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];

          position = "close_to_bar_button";

          shortcuts = {
            left = [
              { id = "WiFi"; }
              { id = "ScreenRecorder"; }
              { id = "WallpaperSelector"; }
            ];

            right = [
              { id = "Notifications"; }
              { id = "PowerProfile"; }
              { id = "KeepAwake"; }
              { id = "NightLight"; }
            ];
          };
        };

        dock = {
          colorizeIcons = false;
          displayMode = "always_visible";
          enabled = false;
          floatingRatio = 1;
          monitors = [ ];
          onlySameOutput = true;
          pinnedApps = [ ];
          size = 1;
        };

        general = {
          animationDisabled = false;
          animationSpeed = 1;
          avatarImage = "${homeDirectory}/Downloads/awawa.jpg";
          compactLockScreen = false;
          forceBlackScreenCorners = false;
          language = "";
          lockOnSuspend = true;
          radiusRatio = 1;
          scaleRatio = 1;
          screenRadiusRatio = 1;
          showScreenCorners = false;
        };

        hooks = {
          darkModeChange = "";
          enabled = false;
          wallpaperChange = "";
        };

        location = {
          analogClockInCalendar = false;
          firstDayOfWeek = -1;
          name = "Salvador, Bahia";
          showCalendarEvents = true;
          showCalendarWeather = true;
          showWeekNumberInCalendar = false;
          use12hourFormat = true;
          useFahrenheit = false;
          weatherEnabled = true;
        };

        network = {
          wifiEnabled = true;
        };

        nightLight = {
          autoSchedule = true;
          dayTemp = "6500";
          enabled = false;
          forced = false;
          manualSunrise = "06:30";
          manualSunset = "18:30";
          nightTemp = "4000";
        };

        notifications = {
          criticalUrgencyDuration = 15;
          doNotDisturb = false;
          location = "top_right";
          lowUrgencyDuration = 3;
          monitors = [ ];
          normalUrgencyDuration = 8;
          overlayLayer = true;
          respectExpireTimeout = false;
        };

        osd = {
          autoHideMs = 2000;
          enabled = true;
          location = "top_right";
          monitors = [ ];
          overlayLayer = true;
        };

        screenRecorder = {
          audioCodec = "opus";
          audioSource = "default_output";
          colorRange = "limited";
          directory = "${homeDirectory}/Videos";
          frameRate = 60;
          quality = "very_high";
          showCursor = true;
          videoCodec = "h264";
          videoSource = "portal";
        };

        settingsVersion = 16;
        setupCompleted = true;

        templates = {
          alacritty = false;
          code = false;
          discord = false;
          discord_armcord = false;
          discord_dorion = false;
          discord_equibop = false;
          discord_lightcord = false;
          discord_vesktop = false;
          discord_webcord = false;
          enableUserTemplates = false;
          foot = false;
          fuzzel = false;
          ghostty = false;
          gtk = false;
          kcolorscheme = false;
          kitty = false;
          pywalfox = false;
          qt = false;
          vicinae = false;
          walker = false;
        };

        ui = {
          fontDefault = "JetBrainsMono Nerd Font";
          fontDefaultScale = 1;
          fontFixed = "Maple Mono NF";
          fontFixedScale = 1;
          panelsAttachedToBar = true;
          panelsOverlayLayer = true;
          tooltipsEnabled = true;
        };

        wallpaper = {
          defaultWallpaper = "${homeDirectory}/wallpapers/wallhaven-pk6y2p_1920x1080.png";
          directory = "${homeDirectory}/wallpapers/";
          enableMultiMonitorDirectories = false;
          enabled = true;
          fillColor = "#000000";
          fillMode = "crop";
          monitors = [
            {
              directory = "${homeDirectory}/Wallpapers/";
              name = "DP-3";
              wallpaper = "${homeDirectory}/Wallpapers/wallhaven-pk6y2p_1920x1080.png";
            }
          ];
          randomEnabled = true;
          randomIntervalSec = 1800;
          recursiveSearch = true;
          setWallpaperOnAllMonitors = true;
          transitionDuration = 1500;
          transitionEdgeSmoothness = 0.05;
          transitionType = "random";
        };
      };
    };
  };
}
