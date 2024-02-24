{pkgs, ...}: {
  home = {
    packages = with pkgs; [pfetch];
    sessionVariables.PF_INFO = "ascii title os kernel shell term desktop memory pkgs uptime scheme palette";
  };
}
