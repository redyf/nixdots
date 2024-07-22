{
  pkgs,
  username,
  ...
}: {
  users = {
    users = {
      username = {
        isNormalUser = true;
        description = username;
        initialPassword = "123456";
        shell = pkgs.zsh;
        extraGroups = ["networkmanager" "wheel" "input" "docker" "kvm" "libvirtd"];
      };
    };
  };
}
