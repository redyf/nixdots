{pkgs, ...}: {
  users = {
    users = {
      redyf = {
        isNormalUser = true;
        description = "redyf";
        initialPassword = "123456";
        shell = pkgs.zsh;
        extraGroups = ["networkmanager" "wheel" "input" "docker" "kvm" "libvirtd"];
      };
    };
  };
}
