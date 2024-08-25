{
  lib,
  stdenv,
  fetchFromGitHub,
  telegram-desktop,
  nix-update-script,
}:

telegram-desktop.overrideAttrs (old: rec {
  pname = "AyuGramDesktop";
  version = "5.4.1";

  src = fetchFromGitHub {
    owner = "AyuGram";
    repo = "${pname}";
    rev = "v${version}";

    fetchSubmodules = true;
    hash = "sha256-7KmXA3EDlCszoUfQZg3UsKvfRCENy/KLxiE08J9COJ8=";
  };

  cmakeFlags = (old.cmakeFlags or [ ]) ++ [ (lib.cmakeBool "disable_autoupdate" true) ];

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "Desktop Telegram client with good customization and Ghost mode.";
    license = licenses.gpl3Only;
    platforms = platforms.all;
    homepage = "https://https://github.com/AyuGram/AyuGramDesktop";
    changelog = "https://https://github.com/AyuGram/AyuGramDesktop/releases/tag/v${version}";
    maintainers = with maintainers; [ hand7s ];
    mainProgram = "ayugram-desktop";
    broken = stdenv.isDarwin;
  };
})
