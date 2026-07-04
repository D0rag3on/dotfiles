{ pkgs, ... }: {
  services.displayManager.sddm = {
    enable = true;
    theme = "pixie";
  };
  
  services.xserver.enable = true;

  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      name = "pixie-sddm";
      src = pkgs.fetchFromGitHub {
        owner = "xCaptaiN09";
        repo = "pixie-sddm";
        rev = "main";
        sha256 = "sha256-0000000000000000000000000000000000000000000=";
      };
      installPhase = ''
        mkdir -p $out/share/sddm/themes/pixie
        cp -r * $out/share/sddm/themes/pixie/
      '';
    })
    pkgs.kdePackages.qtdeclarative
    pkgs.libsForQt5.qt5.qtquickcontrols2
    pkgs.kdePackages.qtsvg
    pkgs.kdePackages.qteffects
  ];
}
