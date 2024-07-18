_: {
  hardware = {
    bluetooth.enable = true;
    raspberry-pi = {
      config = {
        pi5 = {
          dt-overlays = {
            vc4-kms-v3d-pi5 = {
              enable = true;
              params = {};
            };
          };
        };
        all = {
          base-dt-params = {
            # enable autoprobing of bluetooth driver
            # https://github.com/raspberrypi/linux/blob/c8c99191e1419062ac8b668956d19e788865912a/arch/arm/boot/dts/overlays/README#L222-L224
            krnbt = {
              enable = true;
              value = "on";
            };
          };
        };
      };
    };
  };
}
