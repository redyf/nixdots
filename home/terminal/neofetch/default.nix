{ config
, lib
, pkgs
, ...
}: {
  home.packages = [ pkgs.neofetch ];

  home.file."config/neofetch/config.conf" = {
    text = ''
                      print_info() {
                          prin "    ┌─────────\n Hardware Information \n─────────┐"
                          info " ​ ​ 󰌢  " model
                          info " ​ ​ 󰍛  " cpu
                          info " ​ ​   " gpu
                          info " ​  " disk
                          info " ​ ​   " memory
                          info " ​ ​ 󰍹  " resolution
                          prin "    ├─────────\n Software Information \n─────────┤"
                      #    info " ​ ​  " users
                          info " ​ ​  " distro
                          info " ​ ​  " kernel
                          # info " ​ ​  " de
                          info " ​ ​  " wm
                          info " ​ ​  " shell
                          info " ​ ​  " term
                      #    info " ​ ​  " term_font
                      #    info " ​ ​ │  " font
                         # info " ​ ​ 󰉼 " theme
                          # info " ​ ​ 󰀻 " icons
                          info " ​ ​ 󰊠 " packages
                          info " ​ ​  " uptime
                      #     info " ​ ​   " gpu_driver  # Linux/macOS only
                      #     info " ​ ​  " cpu_usage
                      #     info " ​ ​ 󰝚 " song
                          # [[ "$player" ]] && prin "Music Player" "$player"
                      #     info " ​ ​   " local_ip
                      #     info " ​ ​   " public_ip
                      #     info " ​ ​   " locale  # This only works on glibc systems.
                          prin "    └────────────────────────────────────────┘"
                          info cols
                      prin "\n \n \n \n \n  \n \n  \n \n  \n \n   \n \n   \n \n   \n \n   \n \n "
                      }

                      kernel_shorthand="on"
                      distro_shorthand="off"
                      os_arch="on"
                      uptime_shorthand="on"
                      memory_percent="on"
                      package_managers="on"
                      shell_path="off"
                      shell_version="on"
                      speed_type="bios_limit"
                      speed_shorthand="on"
                      cpu_brand="on"
                      cpu_speed="on"
                      cpu_cores="logical"
                      cpu_temp="off"
                      gpu_brand="on"
                      gpu_type="all"
                      refresh_rate="on"
                      gtk_shorthand="on"
                      gtk2="on"
                      gtk3="on"
                      #public_ip_host="http://ident.me"
                      #public_ip_timeout=2
                      disk_show=('/')
                      music_player="vlc"
                      song_format="%artist% - %title%"
                      song_shorthand="off"
                      colors=(distro)
                      bold="on"
                      underline_enabled="on"
                      underline_char="-"
                      separator="  "
                      color_blocks="off"
                      block_range=(0 15) # Colorblocks

                      # Colors for custom colorblocks
                      magenta="\033[0;35m"
                      green="\033[0;32m"
                      white="\033[0;37m"
                      blue="\033[0;34m"
                      red="\033[0;31m"
                      black="\033[0;40;30m"
                      yellow="\033[0;33m"
                      cyan="\033[0;36m"
                      reset="\033[0m"
                      bgyellow="\033[0;43;33m"
                      bgwhite="\033[0;47;37m"
                      cl0=""
                      cl1="magenta"
                      cl2="green"
                      cl3="white"
                      cl4="blue"
                      cl5="red"
                      cl6="yellow"
                      cl7="cyan"
                      cl8="black"
                      cl9="bgyellow"
                      cl10="bgwhite"

                      block_width=4
                      block_height=1

                      bar_char_elapsed="-"
                      bar_char_total="="
                      bar_border="on"
                      bar_length=15
                      bar_color_elapsed="distro"
                      bar_color_total="distro"

                      cpu_display="on"
                      memory_display="on"
                      battery_display="on"
                      disk_display="off"

                      image_backend="--w3m"

      image_source="${config.home.homeDirectory}/home/redyf/.config/neofetch/images/sakurafetch.png"

      ascii_logo = ~/.config/neofetch/ascii/book

                      image_size="small"
                      image_loop="off"
                      ascii_distro="auto"
                      ascii_colors=(distro)
                      ascii_bold="on"

            thumbnail_dir="${config.xdg.cacheHome}/thumbnails/neofetch"
                      crop_mode="normal"
                      crop_offset="center"

                      gap=0

                      yoffset=0
                      xoffset=0

                      stdout="off"

    '';
  };
}
