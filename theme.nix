# Appearance shared by the NixOS and Home Manager Stylix modules.
{
  scheme = "catppuccin-macchiato";
  polarity = "dark";
  cursor = {
    name = "macOS";
    size = 36;
  };
  terminalFontSize = 18;
  # Monospace font for Stylix; `package` is an attribute of the font-flake input.
  monospace = {
    name = "MonoLisa";
    package = "monolisa";
  };
}
