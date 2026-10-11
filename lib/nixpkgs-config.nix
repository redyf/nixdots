# Single nixpkgs `config` shared by every NixOS host (mkHost) and every
# Home Manager configuration (mkHome).
{
  allowUnfree = true;
  permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
    "beekeeper-studio-5.3.4"
    "ventoy-1.1.07"
    "electron-40.10.5"
    "electron-39.8.10"
    "electron-41.10.6"
  ];
}
