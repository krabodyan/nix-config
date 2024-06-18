{ pkgs, ...}: {
  time = {
    timeZone = "Europe/Kiev";
    hardwareClockInLocalTime = true;
  };

  i18n =
  let
    locale = "uk_UA.UTF-8";
  in {
    defaultLocale = locale;
    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psf.gz";
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
  };
}
