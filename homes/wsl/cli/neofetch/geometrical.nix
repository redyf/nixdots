''
  print_info() {
      #info title
      info underline

      prin "\e[31m " CosOS
      #info "Host" model
      #info "Kernel" kernel
      #info "Uptime" uptime
      prin "\e[33m󱋗 " corser
      prin "\e[32m󰏓 " 512
      #info "Resolution" resolution
      #info "DE" de
      prin "\e[34m󱂬 " bspwm
      prin "\e[34m " xor

      
      #info "\e[32m " wm
      #info "\e[32m " resolution
      #info "Theme" theme
      #info "Icons" icons
      #info "Font" font
      #info "GPU" gpu
      info "\e[35m " term
      #info "\e[36m " shell
      #info "\e[34m " shell
      #info "\e[35m " memory

      # info "GPU Driver" gpu_driver  # Linux/macOS only
      # info "CPU Usage" cpu_usage
      # info "Disk" disk
      # info "Battery" battery
      #info "Font" font
      #info "Song" song
      # [[ "$player" ]] && prin "Music Player" "$player"
      # info "Local IP" local_ip
      # info "Public IP" public_ip
      # info "Users" users
      # info "Locale" locale  # This only works on glibc systems.

      #info cols
  }

    title_fqdn="off"
    kernel_shorthand="on"
    distro_shorthand="on"
    os_arch="off"
    uptime_shorthand="tiny"
    memory_percent="on"
    memory_unit="mib"
    package_managers="off"
    shell_path="off"
    shell_version="on"
    speed_type="bios_limit"
    speed_shorthand="on"
    cpu_brand="on"
    cpu_speed="on"
    cpu_cores="logical"
    cpu_temp="C"
    gpu_brand="on"
    gpu_type="all"
    refresh_rate="on"
    gtk_shorthand="on"
    gtk2="on"
    gtk3="on"
    public_ip_host=""
    public_ip_timeout=2
    de_version="on"
    disk_show=('/')
    disk_subtitle="mount"
    disk_percent="on"
    music_player="auto"
    song_format="%artist% - %album% - %title%"
    song_shorthand="on"
    mpc_args=(-p 7777)
    colors=(5 5 5 5 5 7)
    bold="on"
    underline_enabled="on"
    underline_char="━"
    separator="⋮"
    block_range=(0 7)
    color_blocks="off"
    block_width=3
    block_height=1
    col_offset="auto"
    bar_char_elapsed="-"
    bar_char_total="="
    bar_border="on"
    bar_length=15
    bar_color_elapsed="distro"
    bar_color_total="distro"
    cpu_display="off"
    memory_display="off"
    battery_display="off"
    disk_display="off"
    image_backend="kitty"
    image_source="${./ascii/idk.txt}"
    ascii_distro="auto"
    ascii_colors=(distro)
    ascii_bold="on"
    image_loop="off"
    crop_mode="normal"
    crop_offset="center"
    image_size="208px"
    gap=2
    yoffset=0
    xoffset=0
    background_color=
    stdout="off"
''
