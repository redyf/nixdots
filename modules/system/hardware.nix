{ pkgs, ... }:
{
  hardware = {
    graphics =
      if pkgs.stdenv.isx86_64 then
        {
          enable = true;
          enable32Bit = true;
        }
      else
        { enable = true; };
  };
}
