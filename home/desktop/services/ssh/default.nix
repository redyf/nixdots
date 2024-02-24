{pkgs, ...}: {
  # home.packages = with pkgs; [
  #   openssh
  # ];
  # services.openssh = {
  #   enable = true;
  #   ports = [22];
  #   settings = {
  #     PermitRootLogin = "prohibit-password";
  #   };
  # };

  # home.file.".ssh/config".text = ''
  #   identityfile ~/.ssh/key
  # '';
}
