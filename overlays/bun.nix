final: prev: {
  bun = prev.bun.overrideAttrs (_old: rec {
    version = "1.3.14";

    src = final.fetchurl {
      url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-linux-x64.zip";
      hash = "sha256-lR7iruhV8IWVruxiJSJqKY0/6oOj3NZGXAnLzN9+hI8=";
    };
  });
}
